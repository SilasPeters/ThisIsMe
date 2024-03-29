{-# language OverloadedStrings #-}

module HelperMethods where

import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A


-- Generates an acnhor which, when clicked upon, opens the given url in a new tab or window, depending on the browsers settings.
externalLink :: AttributeValue -> Html -> Html
externalLink url = a ! href url ! target "_blank" ! rel "noreferrer noopener"

-- TODO create a general table :: [[Html]] function
-- Generates a table row with two cells
tableRow2 :: Html -> Html -> Html
tableRow2 x y = enumerate tr td [x, y]

-- Generates a table row with three cells
tableRow3 :: Html -> Html -> Html -> Html
tableRow3 x y z = enumerate tr td [x, y, z]

-- Generates a table row with an arbitrary number of cells
tableRow :: Foldable t => t Html -> Html
tableRow = enumerate tr td

-- Generates a 'ul' with an arbitrary number of 'li's
unorderedList :: Foldable t => t Html -> Html
unorderedList = enumerate ul li

-- Generates a 'ol' with an arbitrary number of 'li's
orderedList :: Foldable t => t Html -> Html
orderedList = enumerate ol li

-- Higher level function to nest an arbitrary number of child Html elements under a single parent Html element
enumerate :: Foldable t => (Html -> Html) -> (Html -> Html) -> t Html -> Html
enumerate parent child = parent . mapM_ child

-- The reveres of the Blazer-html (!) operator
apply :: Attribute -> Html -> Html
apply = flip (!)

-- Converts every string to a single 'p'
paragraphs :: [String] -> Html
paragraphs = mapM_ $ p . toHtml
