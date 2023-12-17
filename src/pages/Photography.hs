{-# language OverloadedStrings #-}

module Photography ( page, GalleryOptions(..), PhotoName, PhotoUrl ) where

import Text.Blaze.Html5            as H hiding ( style, contents, header )
import Text.Blaze.Html5.Attributes as A

import Control.Monad                    ( forM_ )
import Prelude                          hiding ( div )

import HelperMethods

-- ===========> Configuration

type PhotoName = String
type PhotoUrl = String

data GalleryOptions = GalleryOptions
  { getHeader      :: String
  , getDescription :: Maybe String
  , getPhotoUrl    :: PhotoName -> PhotoUrl
  , getPhotos      :: [PhotoName]
  }

-- ===========> Page skeleton

page :: GalleryOptions -> Html
page (GalleryOptions header description photoUrl photos) = do
  div ! class_ "centered-container" $ do
    h1 $ toHtml header
    case description of
      Just x  -> p $ toHtml x
      Nothing -> mempty
    div ! class_ "gallery" $ do
      forM_ photos $ apply (class_ "photoFrame") . photoFrame . photoUrl

-- ===========> Construct parts of the webpage

photoFrame :: PhotoUrl -> Html
photoFrame name = img ! src (stringValue name) -- TODO simplify further

