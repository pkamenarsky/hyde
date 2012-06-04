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

items = [["ABOUT US"], ["DEVELOPMENT", "PLANNING", "DEVELOPMENT", "MAINTENANCE"], ["CLIENTS"], ["TEAM"], ["CONTACT"]]

-- Content

title title = divText title ! Id "title"

menu active subactive = div ! Id "menu" </> [div ! Id "menuline"] ++
	intersperse (text "&nbsp;-&nbsp;") spans where

		chClass a b = if a == b then "menuactive" else "menuinactive"
		makeLink item = a item $ home <+> ((++ ".html") $ map toLower $ filter (/= ' ') $ item)

		spans = map (\((item:subitems), i) -> span </>
				if i == active then (makeLink item ! Class "menuactive") :
					map (\(subitem, j) -> div </> [makeLink subitem ! Classes [chClass j subactive, "submenu"]])
						(zip subitems [0..])
				else [makeLink item ! Class "menuinactive"])
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
