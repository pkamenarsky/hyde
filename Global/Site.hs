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

menu active = table ! Id "menu" </> [tr ! Class "menurow" </>
	map (\(item, url, i) ->
			tdTag (a item (home <+> url) ! Class (chose i active "menuactive" "menuinactive")) !
			Class (chose i 0 "menuleft" "menurest"))
		(zip3 items urls [0..])] where
			chose a b c d = if a == b then c else d

site :: Int -> Tag -> IO ()
site active content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "logo.png") home ! Id "logo",
	menu active,
	div ! Id "line",
	div ! Id "main" </>
		[content]]
