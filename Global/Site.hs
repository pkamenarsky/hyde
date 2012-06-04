module Global.Site where

import Prelude hiding (div, span)
import HTML
import Data.Char

-- Globals

up = URL ".."
home = URL "."
resources = up <+> "resources"

-- Menu

items = ["ABOUT US", "DEVELOPMENT", "CLIENTS", "TEAM", "CONTACT"]
urls = map (URL . (++ ".html") . (map toLower) . filter (/= ' ')) items

-- Content

title title = divText title ! Id "title"

menu active = div ! Id "menu" </>
	map (\(item, url, i) -> div </>
			[a item (home <+> url) ! Class (chose i active "menuactive" "menuinactive")])
		(zip3 items urls [0..]) where
			chose a b c d = if a == b then c else d

site :: Int -> Tag -> IO ()
site active content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "logo.png") home ! Id "logo",
	menu active,
	div ! Id "main" </>
		[div ! Id "main-bg",
		content]]
