module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

pitch copy = div ! Class "pitch" </> [divText copy ! Class "pitch-copy"]

titledPitch icon title copy = div ! Classes ["pitch", "pitch-indented"] </>
	[
	-- div ! Class "pitch-separator",
	-- img (resources <+> icon) ! Class "pitch-icon",
	divText title ! Class "pitch-title",
	divText copy ! Class "pitch-copy"]

main = do
	copy <- readFile "Global/philosophy.html"

	site 0 $ div </>
		[title "We create reliable software platforms that are both intuitive and easy to maintain.",
		-- pitch "It pays to do things right the first time; unnecessary changes are ex&shy;pensive. It has been shown that a change in the early stages of a project, in requirements or architecture, costs 50 to 200 times less than the same change later, in construction or maintenance. This is common sense, but we have far too often seen projects slip through deadlines because of this, resulting in unstable releases, feature cuts, unfulfilled promises and angry customers.",
		titledPitch (URL "icon_backend.png") "Robust, fault tolerant backend services" "It pays to do things right the first time; unnecessary changes are ex&shy;pensive. It has been shown that a change in the early stages of a project, in requirements or architecture, costs 50 to 200 times less than the same change later, in construction or maintenance. This is common sense, but we have far too often seen projects slip through deadlines because of this, resulting in unstable releases, feature cuts, unfulfilled promises and angry customers.",
		titledPitch (URL "icon_backend.png") "Robust, fault tolerant backend services" "It pays to do things right the first time; unnecessary changes are ex&shy;pensive. It has been shown that a change in the early stages of a project, in requirements or architecture, costs 50 to 200 times less than the same change later, in construction or maintenance. This is common sense, but we have far too often seen projects slip through deadlines because of this, resulting in unstable releases, feature cuts, unfulfilled promises and angry customers.",
		titledPitch (URL "icon_backend.png") "Natural, intuitive user facing applications" "It pays to do things right the first time; unnecessary changes are ex&shy;pensive. It has been shown that a change in the early stages of a project, in requirements or architecture, costs 50 to 200 times less than the same change later, in construction or maintenance. This is common sense, but we have far too often seen projects slip through deadlines because of this, resulting in unstable releases, feature cuts, unfulfilled promises and angry customers."
		]
