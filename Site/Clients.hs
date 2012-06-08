module Site.Clients where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	site 2 0 $ div </>
		[title "Our references",
		img (resources <+> "raiffeisen_small.png") ! Class "client-logo",
		divText "When building a backend sys&shy;tem we aim for stability, main&shy;tain&shy;abili&shy;ty, precise error repor&shy;ting and efficient procedures for iden&shy;tifying and removing system faults.When building a backend sys&shy;tem we aim for stability, main&shy;tain&shy;abili&shy;ty, precise error repor&shy;ting and efficient procedures for iden&shy;tifying and removing system faults." ! Class "client-text"]
