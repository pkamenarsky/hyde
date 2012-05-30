import Prelude hiding (div, span)
import HTML

menu = ["PHILOSOPHY", "PROCESS", "CLIENTS", "CONTACT"]

main = html HTML5 [CSS $ Segment "style.css"] $ body </>
	[text "YOLO" ! Id "main",
	div ! Id "menu" </> (map (\x -> divText x ! Class "menuitem") menu) ++ [span ! Id "stretcher"],
	div ! Id "line"]
