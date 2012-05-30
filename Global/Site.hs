module Global.Site where

import Prelude hiding (div, span)
import HTML
import Data.Char

-- Globals

up = URL ".."
home = URL "."
resources = up <+> "resources"

-- Menu

items = ["PHILOSOPHY", "PROCESS", "CLIENTS", "TEAM", "CONTACT"]
urls = map (URL . (++ ".html") . (map toLower)) items

-- Content

title :: String -> Tag
title title = text title ! Id "title"

site :: Tag -> IO ()
site content = html HTML5 [CSS $ URL "style.css"] $ body </>
	[
	-- vGrid 21 30,
	imgLink (resources <+> "icon.jpg") home ! Id "logo",
	content ! Id "main",
	div ! Id "menu" </> (map (\(item, url) -> div ! Class "menuitem" </> [a item $ home <+> url]) $ zip items urls) ++ [span ! Id "stretcher"],
	div ! Id "line"]
