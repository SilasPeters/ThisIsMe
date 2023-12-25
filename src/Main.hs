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
import Control.Monad.Trans
import Control.Monad.IO.Class
import Data.Text.Lazy.Encoding ( decodeUtf8 )
import System.Directory ( listDirectory )
import System.IO ( readFile' )
import Data.List ( lookup, sort )
import Data.Maybe ( fromJust )

import HelperMethods

-- Import web pages
import Home
import Projects
import Photography

-- TODO process images to thumbnails, and while you are at it determine the orientations
-- These orientations can then be used to apply the 'vertical' or 'horizontal' class to the photos,
-- to align them on the grid properly. Cus fuck Javascript, that's why.

type Route = String
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
  (reverse $ sort photoNames)

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
    forM_ pages $ \page ->
      H.a H.! A.href (H.stringValue $ mapFirst toLower page) H.!? (page == currentPage, A.id "current-link") $ H.toHtml page
    -- externalLink "https://photos.silaspeters.nl" "Photography"

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
page title page activeSourceButton = S.html $ renderHtml $
  H.docTypeHtml $ do
    header title
    H.body $ do
      navbar title
      sourceButton activeSourceButton
      page

-- Generates the body of a page which displays source code
sourceBody :: SourceCode -> H.Html
sourceBody = H.code . H.toHtml

-- Based on whether the query param "displaySource" is set to true,
-- will generate a page with source code or the original page
normalOrSource :: Title -> H.Html -> SourceCode -> S.ActionM () -- TODO generalise this to a function like Parser.option
normalOrSource title html source = do
  showSource <- S.queryParamMaybe "displaySource" :: S.ActionM (Maybe String)
  case showSource of
    Just "true" -> page title (sourceBody source) True
    _           -> page title html False

exposePage :: [S.RoutePattern] -> S.ActionM () -> S.ScottyM ()
exposePage routes page = forM_ routes $ \r -> S.get r page


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

  S.scotty 3000 $ do
    S.middleware logStdoutDev  -- Log to console
    S.middleware $ staticPolicy (noDots >-> addBase "public")  -- Expose files in /pulic/
    S.middleware $ staticPolicy (noDots >-> addBase "src/pages/")  -- Expose source code

    -- showSource <- (==) "true" <$> S.param "displaySource"
    -- unless (not showSource) $ S.get "/test" $ page "Home" Home.page

    exposePage ["/", "/home"] $ normalOrSource "Home" Home.body (fromJust $ lookup "src/pages/Home.hs" sourceMap)
    -- exposePage ["/projects"]
    --   "Projects" Projects.page "test"
    -- exposePage ["/photography", "/photos", "/fotos"]
    --   "Photography" (Photography.page galleryOptions) "test"

    -- S.get "/param" $ do
    --   v <- S.param "fooparam"
    --   S.html $ mconcat ["<h1>", v, "</h1>"]

    -- S.get "/sexyparam/:aap/noot" $ do
    --   v <- S.param "aap"
    --   S.html $ mconcat ["<h2>", v, "</h2>"]
