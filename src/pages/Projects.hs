{-# language OverloadedStrings #-}

module Projects ( page ) where

import Text.Blaze.Html5 as H hiding ( style, contents, header )
import Text.Blaze.Html5.Attributes as A hiding ( name )

import Control.Monad
import Prelude hiding ( div )

import HelperMethods

data Project = Project { name :: String, description :: String }

repo :: Project -> AttributeValue
repo = stringValue . (++) "https://github.com/SilasPeters/" . name

thumbnail :: Project -> AttributeValue
thumbnail p = stringValue $ "https://raw.githubusercontent.com/SilasPeters/" ++ name p ++ "/main/thumbnail.jpg"

columns :: [(String, [Project])]
columns = [("Secure",
              [Project "Nonexisting" "Test project",
               Project "Testproject" "Testproject"]),
           ("Safe",
              [Project "Testproject" "Testproject",
               Project "Aap" "Noot en Mies",
               Project "Testproject" "Testproject"]),
           ("Sound",
              [Project "Testproject" "Testproject"]),
           ("Simple",
              [Project "ThisIsMe" "Deze zou moeten werken"])]

page :: Html
page = div ! class_ "horizontal-stack" $ do
  h1 "My projects"
  -- Generate columns of tiles representing projects
  forM_ columns $ \(header, projects) ->
    section ! class_ "vertical-highlights" $ do
      h2 ! class_ "highlights-header" $ toHtml header
      tiles projects

-- Generate an arbitrary number of tiles representing projects
tiles :: Foldable t => t Project -> Html
tiles = mapM_ $ \p ->
  apply (class_ "tile") $ externalLink (repo p) $ do
    img ! src (thumbnail p)
    div $ do
      h4 $ toHtml $ name p
      sub $ toHtml $ description p
