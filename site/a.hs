import Prelude hiding (div, span)
import HTML

vGrid height count = div ! Style [Position Absolute, Width 100 Pct, Height 100 Pct] </>
	map (\y -> div ! Style
			[Position Absolute, BGColor 0xffeeee, Width 100 Pct, Height height Px, Top (y * height * 2) Px])
		[0..count]

menu = ["PHILOSOPHY", "PROCESS", "CLIENTS", "CONTACT"]

main = html HTML5 [CSS $ Segment "style.css"] $ body </>
	[
	-- vGrid 21 30,
	text "YOLO" ! Id "main",
	div ! Id "menu" </> (map (\x -> divText x ! Class "menuitem") menu) ++ [span ! Id "stretcher"],
	div ! Id "line"]
