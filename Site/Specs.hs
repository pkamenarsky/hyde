module Site.Specs where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

intro = "Unnecessary changes are expensive. A modification in the early stages of a project, in requirements or architecture, costs 50 to 200 times less than the same change later, in construction or maintenance.<sup>1</sup> This is common sense, but we have far too often seen projects [that haven't been planned out too well??] slip through deadlines, resulting in unstable releases, feature cuts, unfulfilled promises and angry customers."
analyzeDesc = "<i>Specifications --</i> the first step we do before anything else is to sit together with the client and define a clear statement of the problem that the system has to solve. We then continue with a careful formalization of the requirement specifications to a degree that best fits the size, complexity and criticality of the designed platform."
timeDesc = "<i>Offer --</i> estimating the time span of a project's implementation is often done by intuition alone, which frequently leads to unrealistic expectations or overblown budgets. To overcome this, we constantly improve our time estimates by comparing previous analysis with current results. When a bottleneck is found, it is eliminated instead of swept by the side and forgotten about."
methodsDecs = "<i>Development --</i> there are many methodologies for managing software development, but some are better suited to a specific project domain than others. For example, a critical backend service may require rigid and precise specifications and a stricter process of proposing and accepting changes compared to a more casual user-facing application. On the other hand, the latter may benefit from a more iterative prototyping cycle, allowing for faster and easier modifications depending on user tests and client feedback."
balanceDesc = "Striking the perfect balance between too little and too much formality is of great importance for being able to develop software efficiently and on time."

main = do
	site 1 0 $ div </>
		[title "It pays to do things right the first time",
		pitchCopy intro,
		pitch "one.png" analyzeDesc,
		pitch "two.png" timeDesc,
		pitch "three.png" methodsDecs,
		pitchCopy balanceDesc,
		footnote "1. Code Complete, McConnel 1993, p25, cited from Boehm and Pappacio 1988"]
