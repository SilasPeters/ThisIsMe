{-# language OverloadedStrings #-}

import Web.Scotty as S
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import qualified Text.Blaze.Html5 as H
import Control.Monad
import Control.Monad.Trans
import Data.Text.Lazy.Encoding (decodeUtf8)

import Text.Blaze.Html.Renderer.Text (renderHtml)
import Text.Blaze.Html5.Attributes
import Control.Monad.IO.Class

main :: IO ()
main = S.scotty 3000 $ do
  middleware logStdoutDev  -- Log to console
  middleware $ staticPolicy (noDots >-> addBase "static")  -- Expose files in /static
  get "/" $
    text "Hello world!"

  get "/param" $ do
    v <- param "fooparam"
    html $ mconcat ["<h1>", v, "</h1>"]

  get "/sexyparam/:aap/noot" $ do
    v <- param "aap"
    html $ mconcat ["<h2>", v, "</h2>"]

  get "/setbody" $ do
    html $ mconcat ["<form method=POST action=\"readbody\">"
                   ,"<input type=text name=something>"
                   ,"<input type=submit>"
                   ,"</form>"
                   ]

  post "/readbody" $ do
    b <- body
    text $ decodeUtf8 b

  get "/hello" $ do
      html $ renderHtml $
            H.docTypeHtml $
                H.html $ do
                    H.head $
                        H.link H.! rel "stylesheet" H.! href "stylesheet.css"
                    H.body $ do
                        H.h1 "Link Shortener"
                        H.form H.! method "POST" H.! action "/shorten" $ do
                            H.input H.! type_ "text" H.! name "url"
                            H.input H.! type_ "submit" H.! value "Shorten!"

  post "/shorten" $ do
        url <- param "url"
        liftIO $ putStrLn url
        redirect "/"
