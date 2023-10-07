{-# language OverloadedStrings #-}

module Projects ( page ) where

import Text.Blaze.Html5 as H hiding ( style, contents, header )
import Text.Blaze.Html5.Attributes as A hiding ( name )

import Control.Monad
import Prelude hiding ( div )

import HelperMethods

repoUrl :: String -> AttributeValue
repoUrl = stringValue . (++) "https://github.com/SilasPeters/"

repoThumbnail :: String -> AttributeValue
repoThumbnail p = stringValue $ "https://raw.githubusercontent.com/SilasPeters/" ++ p ++ "/main/thumbnail.jpg"

-- repoDescription :: String -> AttributeValue
-- repoDescription = stringValue $ lookAt "description" $ 

columns :: [(String, [String])]
columns = [("Secure",
              ["Nonexisting", "Testproject"]),
           ("Safe",
              ["Testproject", "Aap", "Testproject"]),
           ("Sound",
              ["Testproject"]),
           ("Simple",
              ["ThisIsMe"])]

page :: Html
page = div $ do
  h1 "My projects"
  -- div ! class_ "horizontal-stack" $ do
  -- Generate columns of tiles representing projects
    -- forM_ columns $ \(header, projects) ->
    --   section ! class_ "vertical-highlights" $ do
    --     h2 ! class_ "highlights-header" $ toHtml header
    --     tiles projects

-- Generate an arbitrary number of tiles representing projects
-- tiles :: Foldable t => t Project -> Html
-- tiles = mapM_ $ \p ->
--   apply (class_ "tile") $ externalLink (repo p) $ do
--     img ! src (thumbnail p)
--     div $ do
--       h4 $ toHtml $ name p
--       sub $ toHtml $ description p
