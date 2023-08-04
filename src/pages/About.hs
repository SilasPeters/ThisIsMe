{-# language OverloadedStrings #-}

module About ( page ) where

import Text.Blaze.Html5 as H hiding ( style, contents )
import Text.Blaze.Html5.Attributes as A

import Control.Monad
import Prelude hiding ( div )

import HelperMethods


page :: Html
page = sequence_ [backgroundPicture, contents]

backgroundPicture :: Html
backgroundPicture = img ! class_ "background-picture" ! src "placeholder.jpg"

contents :: Html
contents = div ! class_ "centered-container" $ do
  h1 "About me"
  table ! style "width: 100%;" $ do
---------------------------------------------------------------------- Personal info
    tr $ do
      td $ do
        table ! style "width: 100%;" $ do
          tableRow2 "Name" "Silas"
          tableRow2 "Birthdate" $ toHtml $ "13-02-2003 (" ++ age ++ " years old)"
          tableRow2 "City" "Nieuwegein, the Netherlands"
          tableRow2 "Study" "Bachelor Computer Sciences - Utrecht University"
          tableRow2 "E-mail" $ externalLink "mailto:silaspeters03+thisisme@gmail.com" "silaspeters03@gmail.com"
          tableRow2 "GitHub" $ externalLink "https://github.com/SilasPeters" "SilasPeters"
      td $ img ! src "placeholder.jpg"
    tr $ do
      td $ do
---------------------------------------------------------------------- About me
        h2 ! class_ "highlights-header" $ "About me"
        p "I git gut"
---------------------------------------------------------------------- Working experience
        h2 ! class_ "highlights-header" $ "Working experience"
        p "Werkervaring ook"
---------------------------------------------------------------------- Recommendations
      td ! class_ "sidebar" $ do
        h2 ! class_ "highlights-header" $ "Recommendations"
        div $ do
          div $ do
            img ! src "placeholder.jpg"
            h3 "Frank Goossens"
          p "He can actually git gut"
  
---------------------------------------------------------------------- Study Association
  section $ do
    h2 ! class_ "highlights-header" $ "Study Association"
    div ! style "display: flex; justify-content: space-between;" $ do
      p "I much like dancin'."
      div $ do
        h3 "Commissions participated"
        unorderedList ["CommIT", "ALW", "Media-workgroup", "Selectionboard"]

---------------------------------------------------------------------- Softskills
  section $ do
    h2 ! class_ "highlights-header" $ "Softskills"
    "I much like dancin'."


age :: String
age = "20" -- TODO automate this
