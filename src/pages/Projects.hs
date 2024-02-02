{-# language OverloadedStrings #-}

module Projects ( body, Project (..) ) where

import Text.Blaze.Html5            as H hiding ( style, contents, header, body )
import Text.Blaze.Html5.Attributes as A hiding ( name, rows )

import Control.Monad
import Data.List.Utils                         ( replace )
import Prelude                          hiding ( div )
import HelperMethods (externalLink)

-- ===========> Page skeleton

body :: [Project] -> Html
body projects = div ! class_ "centered-container" $ do
  h1 "My IT projects"
  div ! class_ "projects-collection" $ mapM_ projectTile projects

-- ===========> Define data and properties

data Project = Project { name :: String, description :: String, imageSrc :: String }
  deriving (Show)

-- Gets the URL of the project's repository
projectRepo :: Project -> AttributeValue
projectRepo project = stringValue $ "https://github.com/SilasPeters/" ++ githubName project
  where githubName = replace " " "-" . name

-- ===========> Construct parts of the webpage

projectTile :: Project -> Html
projectTile project =
  externalLink (projectRepo project) ! class_ "projectTile externalIconException" $ do
    img ! src (stringValue $ imageSrc project)
    div $ do
      p ! class_ "projectTile-header" $ toHtml $ name project
      p ! class_ "projectTile-description" $ toHtml $ description project
