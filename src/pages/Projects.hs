{-# language OverloadedStrings #-}

module Projects ( body ) where

import Text.Blaze.Html5            as H hiding ( style, contents, header, body )
import Text.Blaze.Html5.Attributes as A hiding ( name, rows )

import Control.Monad
import Prelude                          hiding ( div )

import HelperMethods

-- ===========> Page skeleton

body :: Html
body = div $ do
  h1 "My projects"
  div ! class_ "horizontal-stack" $ do
  -- Generate rows of tiles representing projects
    forM_ rows $ \(header, projects) ->
      section ! class_ "vertical-highlights" $ do
        h2 ! class_ "highlights-header" $ toHtml header
        mapM_ projectTile projects

-- ===========> Define data and properties

data Project = Project { name :: String, description :: String }

-- Gets the URL of the project's repository
projectRepo :: Project -> AttributeValue
projectRepo p = stringValue $ "https://github.com/SilasPeters/" ++ name p

-- Gets the URL of the project's thumbnail
projectThumbnail :: Project -> AttributeValue
projectThumbnail p = stringValue $ "https://raw.githubusercontent.com/SilasPeters/" ++ name p ++ "/main/thumbnail.jpg"

-- ===========> Construct parts of the webpage

-- Generates the HTML used to display a specified project
projectTile :: Project -> Html
projectTile p =
  apply (class_ "tile") $ externalLink (projectRepo p) $ do
    img ! src (projectThumbnail p)
    div $ do
      h4 $ toHtml $ name p
      sub $ toHtml $ description p

-- Generates the HTML used to display a few projects as highlights
highlights :: Foldable t => t Project -> Html
highlights = undefined

-- The HTML displaying all projects in rows
rows :: [(String, [Project])]
rows = [("Catagory 1",
           [Project "ThisIsMe" "Deze zou moeten werken"]),
        ("Safe",
           [Project "Testproject" "Testproject",
            Project "Aap" "Noot en Mies",
            Project "Testproject" "Testproject"]),
        ("Sound",
           [Project "Testproject" "Testproject"])]

