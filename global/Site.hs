module Global.Site where

import Prelude hiding (div, span)
import HTML
import Data.Char

-- Globals

home = URL "."

-- Menu

items = ["PHILOSOPHY", "PROCESS", "CLIENTS", "CONTACT"]
urls = map (URL . (++ ".html") . (map toLower)) items

-- Content

site :: Tag -> IO ()
site content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	content ! Id "main",
	div ! Id "menu" </> (map (\(item, url) -> div ! Class "menuitem" </> [a item $ home <+> url]) $ zip items urls) ++ [span ! Id "stretcher"],
	div ! Id "line"]
