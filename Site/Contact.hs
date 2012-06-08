module Site.Contact where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

main = do
	site 4 0 $ div </>
		[title "This is how you can contact us",
		divText "Telephone: xxxx 12345678" ! Class "contact-text"]
