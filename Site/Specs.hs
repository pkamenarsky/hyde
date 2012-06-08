module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	copy <- readFile "Global/dev1.html"

	site 1 0 $ div </>
		[title "It pays to do things right the first time",
		pitch "" copy]
