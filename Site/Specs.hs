module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

intro = "Unnecessary changes are expensive. It has been shown that a change in the early stages of a project, in re*-quire*-ments or architecture, costs 50 to 200 times less than the same change later, in construction or main*-te*-nance. This is common sense, but we have far too often seen projects slip through deadlines because of this, re*-sulting in unstable releases, feature cuts, unfulfilled promises and angry customers.<br>***We constantly improve our time estimates by comparing previous analysis with current results. When a bot*-tle*-neck is found it is eliminated instead of swept by the side and forgotten about."
analyzeDesc = "The first step we do before anything else is sit with the client and define a clear statement of the problem that the system is supposed to solve. We then go on to carefully formalize the requirement specifications to a degree that is best suited to the size, complexity and criticality of the designed platform."
methodsDecs = "There are many methodologies for managing software development, but some are better suited to a specific pro*-ject domain than others. For example, a critical backend service may require rigid and precise spec*-ifi*-ca*-tions and a stricter process of proposing and accepting changes compared to a more casual user facing app*-lication. On the other hand, the latter may benefit from a more iterative prototyping cycle, allowing for faster and easier modifications depending on user tests and client feedback.<br>***Striking the perfect balance between too little and too much formality is of great importance for being able to develop efficiently and on time."

main = do
	site 1 0 $ div </>
		[title "It pays to do things right the first time",
		pitch "stats.png" intro,
		pitch "list.png" analyzeDesc,
		pitch "waterfall.png" methodsDecs]
