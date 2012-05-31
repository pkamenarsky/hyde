module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

icons :: [Tag]
icons = map (\y -> imgLink (resources <+> "icon.jpg") home ! Class "icon" ! Style [Top (y * 150) Px]) [0..3]

main = do
	copy <- readFile "Global/philosophy.txt"

	site $ div </>
		[title "This is nice",
		text copy ! Id "column2",
		div ! Id "column1" </>
			icons]
