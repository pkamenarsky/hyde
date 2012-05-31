module Global.Site where

import Prelude hiding (div, span)
import HTML
import Data.Char

-- Globals

up = URL ".."
home = URL "."
resources = up <+> "resources"

-- Menu

items = ["SERVICES", "PROCESS", "CLIENTS", "TEAM", "CONTACT"]
urls = map (URL . (++ ".html") . (map toLower)) items

-- Content

title title = divText title ! Id "title"

menu = table ! Id "menu" </> [tr ! Class "menurow" </>
	map (\(item, url, i) ->
			tdTag (a item $ home <+> url) !
			Class (if i == 0 then "menuleft" else "menurest"))
		(zip3 items urls [0..])]

site :: Tag -> IO ()
site content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "logo.png") home ! Id "logo",
	menu,
	div ! Id "line",
	div ! Id "main" </>
		[content]]
