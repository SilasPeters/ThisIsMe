{-# language OverloadedStrings #-}

module Ruben ( body ) where

import Text.Blaze.Html5            as H hiding ( style, contents, header, body, title )
import Text.Blaze.Html5.Attributes as A hiding ( name, rows )
import Text.Blaze.Internal         as I ( attribute )

import Control.Monad
import Prelude                          hiding ( div )

body, rickroll, center :: Html

allow :: String -> Attribute
allow = attribute (stringTag "allow") (stringTag "allow") . stringValue

frameborder :: Int -> Attribute
frameborder = attribute (stringTag "frameborder") (stringTag "frameborder") . toValue

allowfullscreen :: Attribute
allowfullscreen = attribute (stringTag "allowfullscreen") (stringTag "allowfullscreen") mempty

body = sequence_ [center, div ! class_ "ruben" $ replicateM_ 9 rickroll ]

rickroll = iframe ! class_ "rickroll"
  ! src "https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1&mute=1&si=Nzfr7SP02VCeoN_A&amp;controls=0"
  ! title "YouTube video player"
  ! frameborder 0
  ! allow "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
  ! allowfullscreen
  $ mempty

center = div ! class_ "steam" $ do
  img ! src "ruben.jpg"
