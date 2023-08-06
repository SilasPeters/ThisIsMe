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
backgroundPicture = img ! class_ "background-picture" ! src "media/about_wallpaper.jpg"

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
        mapM_ (p . toHtml) ([
          "Als 3e-jaars Informatica student bij universiteit Utrecht pas ik het beste bij een IT-werkplek. Ik ben bereid samen te werken en om bij te dragen aan het teamgevoel. Ik ben iemand die zoekt naar nieuwe manieren om dingen aan te pakken en hoop dan ook mijn ideeën kwijt te kunnen. Ik ben openminded en ik geef het toe wanneer ik fout zit. In mijn vrije tijd vind ik het fijn om buiten te zijn of om met vrienden de stad in te gaan. Ook ga ik zo nu en dan eropuit voor een foto-wandeling.",
          "Bij mijn studievereniging, mijn werk en eigen projecten heb ik al ervaring met veel gebieden binnen de informatica, maar kan het beste abstract en low-level denken. Daarom heb ik het meest gefocust op .NET en back-end applicaties, maar ook op desktop solutions. Op werk en met eigen projecten heb ik al regelmatig ge-R&D’t. Zo heb ik zelf een TOTP generator geschreven met Haskell.",
          "Binnen mijn studievereniging – Sticky - ben ik erg actief. Ik ben vaak aanwezig in de gezelligheidskamer en help ik binnen verschillende commissies. Zo ben ik sinds kort lid van de mediawerkgroep en help ik met het onderhouden van de IT van de vereniging. Ook heb ik een keer een uitje paintball georganiseerd."
          ] :: [String])
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
      p "I much like dancin'."
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
      "CPR (expired)",
      "Certifiacte for Electronics and Houselamps. Given by 'Vakopleiding Doe het zelf'",
      "Vim"
      ]


age :: String
age = "20" -- TODO automate this
