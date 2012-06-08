module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

area icon title copy = div ! Class "area" </>
	[divText title ! Class "area-title",
	divText copy ! Class "area-copy",
	img (resources <+> icon) ! Class "area-icon"]

main = do
	copy <- readFile "Global/philosophy.html"

	site 0 0 $ div </>
		[title "Reliable software development.",
		-- title "We create reliable software platforms that are both intuitive and easy to maintain.",
		pitch (URL "icon_philosophy.png") "Building operational software on time is a difficult task &mdash; we have seen many projects culminate in mis&shy;behaving systems, dysfunctional user interfaces, blown budgets and broken promises. Blind faith in out&shy;dated man&shy;agement procedures, insufficient evaluation of available technologies and no routines set in place for error analysis are some of the reasons that lead to such state of affairs.<br><br>We try to do better.",
		div ! Id "areas" </>
			[area "main_planning.png" "Web & native" "When developing user facing programs, be it for the web or a specific platform, we concen&shy;trate on usability and user expe&shy;ri&shy;ence; easy software results in satisfied users, higher efficiency and lower support costs.",
			text "&nbsp" ! Class "area-margin",
			area "main_planning.png" "Backend services" "On the backend side we aim for stability, maintainability and pre&shy;cise error reporting; efficient pro&shy;cedures for monitoring service state and identifying and re&shy;mov&shy;ing system faults are equally as important.",
			text "&nbsp" ! Class "area-margin",
			area "main_planning.png" "UX design" "Overloaded user interfaces only lead to confusion and human error; we strive for clean, pleas&shy;ing and logical UIs precisely tai&shy;lored to the specific project do&shy;main, input methods and device restrictions."]]
