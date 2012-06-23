module Site.Team where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	site 3 0 $ div </>
		[title "Our team",
		img (resources <+> "phil.jpg") ! Class "team-logo",
		divText "<b>Philip Kamenarsky</b> When building a backend sys&shy;tem we aim for stability, main&shy;tain&shy;abili&shy;ty, precise error repor&shy;ting and efficient procedures for iden&shy;tifying and removing system faults.When building a backend sys&shy;tem we aim for stability, main&shy;tain&shy;abili&shy;ty, precise error repor&shy;ting and efficient procedures for iden&shy;tifying and removing system faults." ! Class "team-text"]
