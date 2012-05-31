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

title :: String -> Tag
title title = divText title ! Id "title"

menu :: Tag
menu = table ! Id "menu" </> [tr ! Class "menurow" </>
	map (\(item, url, i) ->
			tdTag (a item $ home <+> url) !  Classes (if i == 0 then left else rest))
		(zip3 items urls [0..])] where
			left = ["menuleft"]
			rest = ["menurest"]

site :: Tag -> IO ()
site content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "logo.png") home ! Id "logo",
	menu,
	div ! Id "line",
	div ! Id "main" </>
		[content]]
