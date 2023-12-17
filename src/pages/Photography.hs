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
  { getHeader       :: String
  , getDescription  :: Maybe String
  , getPhotoUrl     :: PhotoName -> PhotoUrl
  , getThumbnailUrl :: PhotoName -> PhotoUrl
  , getPhotos       :: [PhotoName]
  }

-- ===========> Page skeleton

page :: GalleryOptions -> Html
page (GalleryOptions header description photoUrl thumbnailUrl photos) = do
  div ! class_ "centered-container" $ do
    h1 $ toHtml header
    case description of -- TOOD can become a helper method
      Just x  -> p $ toHtml x
      Nothing -> mempty
    div ! class_ "gallery" $ do
      forM_ photos $ \n -> apply (class_ "photoFrame") $ photoFrame (photoUrl n) (thumbnailUrl n)
  script $ toHtml sadlySomeJavascript -- In the future this will be eradicated

-- ===========> Construct parts of the webpage

photoFrame :: PhotoUrl -> PhotoUrl -> Html
photoFrame originalUrl thumbnailUrl =
  img ! src (stringValue thumbnailUrl) ! data_ (stringValue originalUrl)

sadlySomeJavascript :: String
sadlySomeJavascript = unlines
  [ "// Forgive me, for I have sinned."
  , "// I vowed to never use Javascript for this project, alas."
  , "// Until I implement my media pipeline, this must suffice."
  , ""
  , "document.addEventListener('DOMContentLoaded', function () {"
  , ""
  , "  // Get all images with the class 'clickableImage'"
  , "  const clickableImages = document.querySelectorAll('img');"
  , ""
  , "  // Create overlay element"
  , "  const overlay = document.createElement('div');"
  , "  overlay.id = 'overlay';"
  , ""
  , "  // Create enlarged image element"
  , "  const enlargedImg = document.createElement('img');"
  , "  enlargedImg.id = 'enlargedImg';"
  , ""
  , "  // Append elements to the body"
  , "  document.body.appendChild(overlay);"
  , "  document.body.appendChild(enlargedImg);"
  , ""
  , "  clickableImages.forEach(function (image) {"
  , "    image.addEventListener('click', function () {"
  , "      // Darken the screen"
  , "      overlay.style.display = 'flex';"
  , ""
  , "      // Display the enlarged image based on the clicked image"
  , "      enlargedImg.src = image.getAttribute('data');"
  , "      enlargedImg.style.display = 'block';"
  , "    });"
  , "  });"
  , ""
  , "  overlay.addEventListener('click', function () {"
  , "    // Hide the overlay and enlarged image when clicking outside the image"
  , "    overlay.style.display = 'none';"
  , "    enlargedImg.style.display = 'none';"
  , "    enlargedImg.src = '';"
  , "  });"
  , "});"
  ]
