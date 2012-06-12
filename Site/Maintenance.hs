module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

intro = "Having stable requirements is a wish we've frequently seen shared between both customers and implementors; still, it is something that is rarely achieved in practice. On a typical project it is nearly impossible to conclusively describe what is needed before a sizeable chunk of the code has been written and the system is already partly operational; this is why it is essential to establish a lightweight and effective process for submitting and implementing change requests."
toolsDesc = "Depending on the rigidity of a project, a change request may just be an email containing the modifications the client wishes to introduce to the system and an answer containing the cost estimate for those from our side; or it may have to go through a joint committee, careful discussions and multiple layers of approval on both the customer's and our ends before implementation. In any case, we aim to specify the level of formality for a change request as early as possible in order to avoid needless confusion and misunderstandings."
costDesc = "After the system has been implemented and deployed, there is still work left to be done. Keeping servers up to date, monitoring operational state, refining user interfaces, identifying and removing bottlenecks and fixing bugs are all things that need to be regularly performed after development. However, the work and thus the cost needed for doing many of these tasks can be kept to a minimum; the use of tools well tailored to a specific domain and careful design and implementation aim to make future modifications as frictionless as possible."

main = do
	site 1 2 $ div </>
		[title "Keeping it operational",
		pitch "tool.png" intro,
		pitch "tool.png" toolsDesc,
		pitch "tool.png" costDesc]
