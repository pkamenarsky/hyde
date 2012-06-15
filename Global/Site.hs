module Global.Site (site, title, title2, resources, pitch, pitchCopy, titledPitch) where

import Prelude hiding (div, span)
import HTML
import Data.Char
import Data.String.Utils
import List hiding (span)

-- Globals

up = URL ".."
home = URL "."
resources = up <+> "resources"

-- Menu

items = [["About Us"], ["Process", "Specs", "Development", "Maintenance"], ["Clients"], ["Team"], ["Contact"]]

-- Content

format = (replace "*-" "&shy;") . (replace "--" "&mdash;") . (replace "***" "&nbsp;&nbsp;&nbsp;")

title title = divText title ! Id "title"
title2 title = divText title ! Class "pitch-title"

pitch icon copy = div ! Class "pitch" </>
	[divText (format copy) ! Class "pitch-copy" </>
		[img (resources <+> icon) ! Class "pitch-icon",
		div ! Class "pitch-separator"]
	--	[]
		]

pitchCopy copy = div ! Class "pitch" </>
	[divText (format copy) ! Class "pitch-copy"]

titledPitch icon title copy = div ! Class "pitch" </>
	[divText title ! Class "pitch-title",
	divText (format copy) ! Class "pitch-copy" </>
		[img (resources <+> icon) ! Class "pitch-icon"]]

menu active sactive = div ! Id "menu" </> (div ! Id "menuline") :
	intersperse (divText "&nbsp;-&nbsp;") spans where

		getLink (x:y:_) = y
		getLink (x:_) = x

		mkLink name link = a (map toUpper name) $ home <+> ((++ ".html") $ map toLower $ filter (/= ' ') $ link)
		mkSublinks subitems = map (\(sitem, j) ->
				mkLink sitem sitem ! Classes [if j == sactive then "menuactive" else "menuinactive", "submenu"])
			(zip subitems [0..])

		spans = map (\(all@(item:subitems), i) -> div </>
				if i == active
					then (mkLink item (getLink all) ! Class "menuactive") : mkSublinks subitems
					else [mkLink item (getLink all) ! Class "menuinactive"])
			(zip items [0..])

pagetitle = ("harmonious software - " ++) . head . (items !!)

site :: Int -> Int -> Tag -> IO ()
site active subactive content = html (pagetitle active)  HTML5 [CSS $ URL "style.css"] $ body </>
	[div ! Id "bg" </>
		[
		-- vGrid 21 30,
		imgLink (resources <+> "logo.png") home ! Id "logo",
		div ! Id "main" </>
			[menu active subactive,
			content]]]
