module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	copy <- readFile "Global/dev1.html"

	site 1 1 $ div </>
		[title "Development",
		pitch "" copy]
