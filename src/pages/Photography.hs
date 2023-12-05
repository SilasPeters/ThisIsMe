{-# language OverloadedStrings #-}

module Photography ( page ) where

import Text.Blaze.Html5            as H hiding ( style, contents, header )
import Text.Blaze.Html5.Attributes as A

import Control.Monad                    ( forM_ )
import Prelude                          hiding ( div )

import HelperMethods

-- ===========> Page skeleton

page :: [String] -> Html
page photos = div $ do
  h1 "My hand-picked photos"
  div ! class_ "gallery" $ do
    forM_ photos $ apply (class_ "photoFrame") . photoFrame

-- ===========> Define data and properties

photoViewUrl :: String -> AttributeValue 
photoViewUrl = stringValue . (++) "photography/" -- TODO move this to parameter of page

photoSrc :: String -> AttributeValue
photoSrc = stringValue . (++) "photo/" -- TODO move this to parameter of page

-- ===========> Construct parts of the webpage

photoFrame :: String -> Html
photoFrame name = a ! href (photoViewUrl name) $ img ! src (photoSrc name)

