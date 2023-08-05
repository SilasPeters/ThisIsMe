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

-- import HelperMethods
import HelperMethods

-- Import web pages
import qualified Home
import qualified About
import qualified Projects
import qualified Stack


-- This list contains the names of all pages to be made available
pages :: [String]
pages = ["Home", "About", "Projects", "Stack"] -- TODO interpret this from the files in src/pages.

-- Defines default html header properties
header :: String -> H.Html
header pageTitle = H.header $ do
  H.meta H.! A.charset "UTF-8"
  H.meta H.! A.name "viewport" H.! A.content "width=device-width,initial-scale=1"
  H.title $ H.toHtml $ "This is Silas Peters - " ++ pageTitle
  H.link H.! A.rel "stylesheet" H.! A.href "stylesheet.css"
  
-- Generates Html code which defines the navbar
navbar :: String -> H.Html
navbar currentPage = H.nav H.! A.class_ "navbar-container" $ do
  H.div H.! A.class_ "navbar-body centered-container" $ do
    forM_ pages $ \page ->
      H.a H.! A.href (H.stringValue $ mapFirst toLower page) H.!? (page == currentPage, A.id "current-link") $ H.toHtml page
    externalLink "https://photos.silaspeters.nl" "Photography"

-- The button to toggle the view between html and haskell code, displayed in the bottom-right corner
sourceButton :: H.Html
sourceButton = H.button H.! A.id "source-button" $
  H.img H.! A.src "media/source-enable.png"

-- Displays given Html by inserting it into the global template
view :: String -> H.Html -> S.ActionM ()
view pageName page = S.html $ renderHtml $
  H.docTypeHtml $ do
    header pageName
    H.body $ do
      navbar pageName
      sourceButton
      page

-- Set up middleware and routing (the API side)
main :: IO ()
main = S.scotty 3000 $ do
  S.middleware logStdoutDev  -- Log to console
  S.middleware $ staticPolicy (noDots >-> addBase "public")  -- Expose files in /public

  S.get "/" $ view "Home" Home.page

  S.get "/home"     $ view "Home"     Home.page
  S.get "/about"    $ view "About"    About.page
  S.get "/projects" $ view "Projects" Projects.page
  S.get "/stack"    $ view "Stack"    Stack.page

  -- S.get "/param" $ do
  --   v <- S.param "fooparam"
  --   S.html $ mconcat ["<h1>", v, "</h1>"]

  -- S.get "/sexyparam/:aap/noot" $ do
  --   v <- S.param "aap"
  --   S.html $ mconcat ["<h2>", v, "</h2>"]

-- TODO add favicon