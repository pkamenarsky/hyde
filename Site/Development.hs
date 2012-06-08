module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	copy <- readFile "Global/dev2.html"

	site 1 1 $ div </>
		[title "Chosing the right technology",
		pitch "" copy]
