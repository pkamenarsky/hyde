module Site.Philosophy where

import Global.Site
import Prelude hiding (div)
import HTML

icons :: [Tag]
icons = map (\y -> imgLink (resources <+> "icon.jpg") home ! Class "icon" ! Style [Top (y * 150) Px]) [0..3]

main = site $ div </>
	[title "This is nice",
	text "asdasd" ! Id "column2",
	div ! Id "column1" </>
		icons]
