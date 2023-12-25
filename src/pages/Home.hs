{-# language OverloadedStrings #-}

module Home ( body ) where

import Text.Blaze.Html5 as H            hiding ( body )
import Text.Blaze.Html5.Attributes as A

import Control.Monad
import Prelude hiding ( div )

-- ===========> Page skeleton

body :: Html
body = sequence_ [bigpicture, disclaimer]

-- ===========> Construct parts of the webpage

bigpicture :: Html
bigpicture = section ! class_ "bigpicture" $ do
  img ! src "media/splash.jpg"
  div $ do
    sub "This is"
    h1 "Silas Peters"

highlights :: Html -- NOT USED
highlights = section ! class_ "centered-container" $ do
  section $ do
    h2 ! class_ "highlights-header" $ "Experience with a broad range of languages"
    div ! class_ "highlights" $ do
      a ! class_ "tile" ! href "projects#kaas" $ do
        img ! src "placeholder.jpg"
        p ! class_ "tile-description" $ "This is a test"
      a ! class_ "tile" ! href "projects#bier" $ do
        img ! src "placeholder.jpg"
        p ! class_ "tile-description" $ "Aap noot mies"
    h2 ! class_ "highlights-header" $ "Surprising"
    div ! class_ "surprise" $ do
      p "This site is not made with some mainstream framework, but with"
      img ! src "media/haskell.png" ! alt "Haskell"
      p $ do
        "Press the floating button on the bottom-right to display this page's code. You can view this project on the "
        a ! href "projects#thisIsMe" $ "Projects" -- TODO make the # trick work
        " page to find out more."

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
    
