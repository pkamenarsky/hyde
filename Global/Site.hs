module Global.Site where

import Prelude hiding (div, span)
import HTML
import Data.Char
import List hiding (span)

-- Globals

up = URL ".."
home = URL "."
resources = up <+> "resources"

-- Menu

items = [["ABOUT US"], ["PROCESS", "PLANNING", "DEVELOPMENT", "MAINTENANCE"], ["CLIENTS"], ["TEAM"], ["CONTACT"]]

-- Content

title title = divText title ! Id "title"

menu active sactive = div ! Id "menu" </> (div ! Id "menuline") :
	intersperse (text "&nbsp;-&nbsp;") spans where

		getLink (x:y:_) = y
		getLink (x:_) = x

		mkLink name link = a name $ home <+> ((++ ".html") $ map toLower $ filter (/= ' ') $ link)
		mkSublinks subitems = map (\(sitem, j) ->
				mkLink sitem sitem ! Classes [if j == sactive then "menuactive" else "menuinactive", "submenu"])
			(zip subitems [0..])

		spans = map (\(all@(item:subitems), i) -> span </>
				if i == active
					then (mkLink item (getLink all) ! Class "menuactive") : mkSublinks subitems
					else [mkLink item (getLink all) ! Class "menuinactive"])
			(zip items [0..])

site :: Int -> Int -> Tag -> IO ()
site active subactive content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "logo.png") home ! Id "logo",
	div ! Id "main" </>
		[menu active subactive,
		div ! Id "main-bg",
		content]]
