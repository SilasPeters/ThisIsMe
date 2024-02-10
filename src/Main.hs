{-# language OverloadedStrings #-}

-- help: https://github.com/scotty-web/scotty/blob/master/examples/upload.hs

import qualified Web.Scotty as S
import Network.Wai.Middleware.RequestLogger ( logStdoutDev )
import Network.Wai.Middleware.Static ( staticPolicy, noDots, (>->), addBase )
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text ( renderHtml )
import Data.Char ( toLower )

import Control.Monad
import System.Directory ( listDirectory )
import System.IO ( readFile' )
import System.FilePath ( joinPath )
import Data.List ( sortBy, isSuffixOf )
import Data.Maybe ( fromJust )
import Data.Ord ( comparing, Down(..) )

import HelperMethods

-- Import web pages
import Home
import Projects
import Photography
import Ruben

-- TODO process images to thumbnails, and while you are at it determine the orientations
-- These orientations can then be used to apply the 'vertical' or 'horizontal' class to the photos,
-- to align them on the grid properly. Cus fuck Javascript, that's why.

type SourceCode = String
type Title = String

-- This list contains the names of all pages to be made available
pages :: [String]
pages = ["Home", "Projects", "Photography"]

defineGalleryOptions :: [PhotoName] -> GalleryOptions
defineGalleryOptions photoNames = GalleryOptions
  "My hand-picked photos"
  (Just "Displayed in reverse chronological order")
  ("/portfolio/" ++)
  ("/portfolioThumbnails/" ++)
  (sortBy (comparing Down) photoNames)

projects :: String -> (String -> String) -> IO [Project]
projects projectsFolder toImageSrc = do
  projectNames         <- filter (not . isSuffixOf ".jpg") <$> listDirectory projectsFolder
  let projectPaths      = map (\n -> joinPath [projectsFolder, n]) projectNames --TODO use joinPath everywhere?
  projectDescriptions  <- mapM readFile projectPaths
  let projectImagePaths = map (toImageSrc . flip (++) ".jpg" ) projectNames
  return $ zipWith3 Project projectNames projectDescriptions projectImagePaths

-- Defines default html header properties
header :: String -> H.Html
header pageTitle = H.header $ do
  H.meta H.! A.charset "UTF-8"
  H.meta H.! A.name "viewport" H.! A.content "width=device-width, initial-scale=1"
  H.title $ H.toHtml $ "This is Silas Peters - " ++ pageTitle
  H.link H.! A.rel "stylesheet" H.! A.href "stylesheet.css"

-- Generates Html code which defines the navbar
navbar :: String -> H.Html
navbar currentPage = H.nav H.! A.class_ "navbar-container" $ do
  H.div H.! A.class_ "navbar-body centered-container" $ do
    forM_ pages $ \pageName ->
      H.a H.! A.href (H.stringValue $ map toLower pageName) H.!? (pageName == currentPage, A.id "current-link") $ H.toHtml pageName
      -- TODO here and in the routing section, you define the URL in different ways. Use a Map of (name, route(s))

-- The button to toggle the view between html and haskell code, displayed in the bottom-right corner
sourceButton :: Bool -> H.Html
sourceButton active = H.button H.! A.id "source-button" H.! A.onclick onclickHref $
  H.img H.! A.src imgSrc
  where
    onclickHref = if not active then "location.href='?displaySource=true'" else "location.href=location.href.split('?')[0]"
    imgSrc = if not active then "media/source-enable.png" else "media/source-disable.png"

-- Preloads all source code to be displayed
loadSource :: String -> IO [(String, String)]
loadSource sourceFolder = do
  filePaths <- map (sourceFolder ++) <$> listDirectory sourceFolder
  zip filePaths <$> mapM readFile' filePaths

-- Fills the page template with the given body
page :: Title -> H.Html -> Bool -> S.ActionM ()
page title html activeSourceButton = S.html $ renderHtml $
  H.docTypeHtml $ do
    header title
    H.body $ do
      navbar title
      sourceButton activeSourceButton
      html

-- Generates the body of a page which displays source code
sourceBody :: SourceCode -> H.Html
sourceBody = apply (A.class_ "source") . H.pre . H.code . H.toHtml

-- Based on whether the query param "displaySource" is set to true,
-- will generate a page with source code or the original page
normalOrSource :: Title -> H.Html -> SourceCode -> S.ActionM () -- TODO generalise this to a function like Parser.option
normalOrSource title html source = do
  showSource <- S.queryParamMaybe "displaySource" :: S.ActionM (Maybe String)
  case showSource of
    Just "true" -> page title (sourceBody source) True
    _           -> page title html False

exposePage :: [S.RoutePattern] -> S.ActionM () -> S.ScottyM ()
exposePage routes html = forM_ routes $ \r -> S.get r html


-- Set up middleware and routing (the API side)
main :: IO ()
main = do
  -- Process portfolio
  photoNames <- listDirectory "public/portfolio"
  let galleryOptions = defineGalleryOptions photoNames
  putStrLn "Processed portfolio images:"
  mapM_ (putStrLn . (++) " - ") photoNames

  -- Process source code to be displayed
  sourceMap <- loadSource "src/pages/"
  putStrLn "Pre-loaded source files:"
  mapM_ (putStrLn . (++) " - " . fst) sourceMap

  loadedProjects <- projects "public/projects/" ("projects/" ++)
  putStrLn "Processed projects:"
  mapM_ (putStrLn . (++) " - " . show) loadedProjects

  S.scotty 3000 $ do
    S.middleware logStdoutDev  -- Log to console
    S.middleware $ staticPolicy (noDots >-> addBase "public")  -- Expose files in /pulic/
    S.middleware $ staticPolicy (noDots >-> addBase "src/pages/")  -- Expose source code

    exposePage ["/", "/home"] $ normalOrSource "Home" Home.body (fromJust $ lookup "src/pages/Home.hs" sourceMap)
    exposePage ["/projects"] $ normalOrSource "Projects" (Projects.body loadedProjects) (fromJust $ lookup "src/pages/Projects.hs" sourceMap)
    exposePage ["/photography", "/photos", "/fotos"] $ normalOrSource "Photography" (Photography.body galleryOptions) (fromJust $ lookup "src/pages/Photography.hs" sourceMap)
    exposePage ["/ruben"] $ page "Ruben" Ruben.body False

