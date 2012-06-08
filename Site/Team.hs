module Site.Team where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	site 3 0 $ div </>
		[title "Our team."]
