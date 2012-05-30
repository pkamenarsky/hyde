import Prelude hiding (div)
import HTML

data Person = Person {name :: String, age :: Int}

home = Segment "home"
post = Segment "post"

sperson :: Person -> Tag
sperson (Person name age) = div </> [stitle name, text $ show age]

stitle :: String -> Tag
stitle title = text title ! Class "title" </> [a [home, post] "post"]

ssite :: Tag -> Tag
ssite tag =
	div ! Class "main" </>
		[div ! Class "content" </>
			[tag]]

main = html HTML5 [] $
	div ! Id "container" </>
		[div ! Id "container2",
		div ! Id "uuu" </>
			[ssite $ stitle "This is a site - is it?",
			sperson $ Person "John Carmack" 7]]

