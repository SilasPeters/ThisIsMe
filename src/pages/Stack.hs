{-# language OverloadedStrings #-}

module Stack ( page ) where

import Text.Blaze.Html5 as H hiding ( style, contents, header )
import Text.Blaze.Html5.Attributes as A hiding ( name )

import Control.Monad
import Prelude hiding ( div )

import HelperMethods

contents :: [(String, [String])]
contents = [
  ("Favourite IDE's",
    ["placeholder.jpg", "placeholder.jpg", "placeholder.jpg"]),
  ("Setup",
    ["placeholder.jpg", "placeholder.jpg", "placeholder.jpg"]),
  ("Collaborative tools",
    ["placeholder.jpg", "placeholder.jpg", "placeholder.jpg"])
  ]


page :: Html
page = div ! class_ "centered-container" $ do
  h1 "My stack"
  section $ do -- These represent the languages
    img ! src "placeholder.jpg"
    img ! src "placeholder.jpg"
    img ! src "placeholder.jpg"
  forM_ contents $ \(header, images) -> section $ do
    h2 ! class_ "highlights-header" $ toHtml header
    div ! class_ "highlights" $
      forM_ images $ (!) img . src . stringValue
