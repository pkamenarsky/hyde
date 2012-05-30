module Global.Global where

import Prelude hiding (div, span)
import HTML
import Data.Char

-- Globals

home = URL "home"

-- Menu

items = ["PHILOSOPHY", "PROCESS", "CLIENTS", "CONTACT"]
urls = map (URL . (++ ".html") . (map toLower)) items

-- Content

site = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	text "YOLO" ! Id "main",
	div ! Id "menu" </> (map (\(item, url) -> div ! Class "menuitem" </> [a item $ home <+> url]) $ zip items urls) ++ [span ! Id "stretcher"],
	div ! Id "line"]
