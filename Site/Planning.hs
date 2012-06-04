module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

pitch copy = div ! Class "pitch" </> [divText copy ! Class "pitch-copy"]

titledPitch icon title copy = div ! Class "pitch" </>
	[
	-- img (resources <+> icon) ! Class "pitch-icon",
	divText title ! Class "pitch-title",
	divText copy ! Class "pitch-copy"]

main = do
	copy <- readFile "Global/dev1.html"

	site 1 0 $ div </>
		[title "It pays to do things right the first time.",
		pitch copy]
