module Global.Site (site, title) where

import Prelude hiding (div, span)
import HTML
import Data.Char
import List hiding (span)

-- Globals

up = URL ".."
home = URL "."
resources = up <+> "resources"

-- Menu

items = [["About Us"], ["Process", "Planning", "Development", "Maintenance"], ["Clients"], ["Team"], ["Contact"]]

-- Content

title title = divText title ! Id "title"

menu active sactive = div ! Id "menu" </> (div ! Id "menuline") :
	intersperse (text "&nbsp;-&nbsp;") spans where

		getLink (x:y:_) = y
		getLink (x:_) = x

		mkLink name link = a (map toUpper name) $ home <+> ((++ ".html") $ map toLower $ filter (/= ' ') $ link)
		mkSublinks subitems = map (\(sitem, j) ->
				mkLink sitem sitem ! Classes [if j == sactive then "menuactive" else "menuinactive", "submenu"])
			(zip subitems [0..])

		spans = map (\(all@(item:subitems), i) -> span </>
				if i == active
					then (mkLink item (getLink all) ! Class "menuactive") : mkSublinks subitems
					else [mkLink item (getLink all) ! Class "menuinactive"])
			(zip items [0..])

pagetitle = ("harmonious software - " ++) . head . (items !!)

site :: Int -> Int -> Tag -> IO ()
site active subactive content = html (pagetitle active)  HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "logo.png") home ! Id "logo",
	div ! Id "main" </>
		[menu active subactive,
		div ! Id "main-bg",
		content]]
