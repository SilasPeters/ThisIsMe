{-# language OverloadedStrings #-}

module Home ( body ) where

import Text.Blaze.Html5 as H            hiding ( body )
import Text.Blaze.Html5.Attributes as A
import Prelude hiding ( div )

body, bigpicture, welcome, haskell :: Html

body = sequence_ [bigpicture,
  section ! class_ "divide" $ do
    welcome
    haskell
  ]

bigpicture = section ! class_ "bigpicture" $ do
  img ! src "media/splash.jpg"
  div $ do
    sub "This is"
    h1 "Silas Peters"

welcome = div ! class_ "welcome" $ do
  h1 "Hi there!"
  p "This is my personal website, where I showcase the things I am most proud of. Have a look around!"

haskell = div ! class_ "haskell" $ do
  img ! src "media/haskell.png" ! alt "Haskell logo" -- TODO apply alt everywhere
  p "This site is not made with some mainstream framework, but proudly with haskell! View the code of the current page by clicking on the green floating button on the right."

