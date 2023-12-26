{-# language OverloadedStrings #-}

module Home ( body ) where

import Text.Blaze.Html5 as H            hiding ( body )
import Text.Blaze.Html5.Attributes as A

import Control.Monad
import Prelude hiding ( div )

-- ===========> Page skeleton

body :: Html
body = sequence_ [bigpicture, disclaimer, haskell]

-- ===========> Construct parts of the webpage

bigpicture :: Html
bigpicture = section ! class_ "bigpicture" $ do
  img ! src "media/splash.jpg"
  div $ do
    sub "This is"
    h1 "Silas Peters"

haskell :: Html
haskell = section ! class_ "centered-container haskell" $ do
    p "This site is not made with some mainstream framework, but proudly with"
    img ! src "media/haskell.png" ! alt "Haskell logo" -- TODO apply alt everywhere
    p "View the code of the current page by clicking on the floating button on the bottom-right."

choice :: Html
choice = section $ do
  div $ do -- both choices
    a ! href "projects" $ do
      p "Projects"
    a ! href "photography" $ do
      p "Photography"

disclaimer :: Html
disclaimer = section ! class_ "centered-container" $ do
  h1 "This website is not done!"
  p "While I am still desciding what content to place here, you should not expect things to look fabulous."
  em "Check out my photos though, that page is done!"

