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
backgroundPicture = img ! class_ "background-picture-reverse-mask" ! src "media/about_wallpaper.jpg"

contents :: Html
contents = div ! class_ "centered-container" $ do
  h1 "About me"
  table ! style "width: 100%;" $ do
---------------------------------------------------------------------- Personal info
    tr $ do
      td $ do
        table ! style "width: 100%;" $ do
          tableRow2 "Fulle Name" "Silas H.M. Peters"
          tableRow2 "Birthdate" $ toHtml $ "13-02-2003 (" ++ age ++ " years old)"
          tableRow2 "City" "Nieuwegein, the Netherlands"
          tableRow2 "Study" "Bachelor Computer Sciences - Utrecht University"
          tableRow2 "Phone" "+31 6 2835 4429"
          tableRow2 "E-mail" $ externalLink "mailto:silaspeters03+thisisme@gmail.com" "silaspeters03@gmail.com"
          tableRow2 "GitHub" $ externalLink "https://github.com/SilasPeters" "SilasPeters"
      td $ img ! src "media/me1.jpg" ! width "300px"
    tr $ do
      td $ do
---------------------------------------------------------------------- About me
        h2 ! class_ "highlights-header" $ "About me"
        paragraphs [
          "Creativity, problem-solving and loyalty.",
          "Creativity, for that I enjoy imagining new experiences and creating something out of nothing. I try to look at something in a way nobody has done before.",
          "Problem-solving, for I constantly find myself trying to optimise current systems and love to set my teeth in asbtract or low-level problems. My fullest potential can be reached in an environment where ideas can be shared freely.",
          "Loyalty, for I believe that's the most beautifull yet important property someone can have.",
          "As a Computer Sciences student at Utrecht University, I take great interest in the emergent properties of (complex) computer systems. However, I most enjoy practising my computer knowledge by creating new tools, enviroments and experiences, or algorithms which allow me to be creative - either by sculpting my fantasy into reality, or by needing to think of a solution the best (and the most neat way) I can.",
          "Computers are the actuators of human fantasy."
          ]
---------------------------------------------------------------------- Working experience
        h2 ! class_ "highlights-header" $ "Working experience"
        table $ do
          tableRow ["2022/07/07", "-", "Present Day", sequence_ [toHtml ("Cloud engineer at " :: String), externalLink "https://holomoves.nl/" "HoloMoves"]]
          tableRow ["2019/08/05", "-", "2022/04/03", "Sales assistant at Praxis Nieuwegein, department Electrics and Powertools"]
          tableRow ["2018/08/20", "-", "2019/08/03", "Stock clerk at Albert Heijn"]
---------------------------------------------------------------------- Education
        h2 ! class_ "highlights-header" $ "Education"
        table $ do
          tableRow ["September 2023", "-", "January 2024", "Minor Game Design - HKU"]
          tableRow ["September 2021", "-", "Present day",  "Bachelor Computer Sciences - Utrecht University"]
          tableRow ["August 2015",    "-", "July 2021",    "Bilingual VWO - Anna van Rijn College Nieuwegein"]
          tableRow ["",               "",  "",             " - NT/NG + Computer Science"]
---------------------------------------------------------------------- Recommendations
      td ! class_ "sidebar" $ do
        h2 ! class_ "highlights-header" $ "Recommendations"
        div $ do
          div $ do
            img ! src "media/FrankGoossens.jpg" ! width "40%;"
            h3 "Frank Goossens"
            div ! style "margin-left: 20px;" $ do
              p "Filiaalmanager at Praxis Nieuwegein"
              externalLink "mailto:ma-2319@praxis.nl" "ma-2319@praxis.nl"
          p "\"Iemand waar je op kan rekenen 💪\""
  
---------------------------------------------------------------------- Study Association
  section $ do
    h2 ! class_ "highlights-header" $ "Study Association"
    div ! style "display: flex; justify-content: space-between;" $ do
      paragraphs [
        "I am really active at my study association 'Sticky'. Often times I enjoy a drink at the recreation roomto socialise. Also, I am active in multiple comissions listed on the right. Mostly I help out by improving and maintaining the IT of Sticky, but I am also becoming the main photographer. I also hosted some activities, like paintball.",
        "I have learned a lot through Sticky, and have had many opportunies thanks to the people in it. For example, I was invited to the selectionboard for the new program director of the bachelor Computer Sciences!"
        ]
      div $ do
        h3 "Commissions participated"
        unorderedList ["CommIT", "ALW", "Media-workgroup", "Selectionboard"]

---------------------------------------------------------------------- Softskills
  section $ do
    h2 ! class_ "highlights-header" $ "Softskills"
    unorderedList [
      "Microsoft Office Specialist Master",
      "Microsoft Technology Associate certificaat",
      "IB/Nuffic Certificate",
      "Photography cursus at Parnassos",
      "CPR (certificate expired)",
      "Certifiacte for Electronics and Houselamps. Given by 'Vakopleiding Doe het zelf'",
      "Vim"
      ]


age :: String
age = "20" -- TODO automate this
