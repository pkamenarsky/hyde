import HTML

data Person = Person {name :: String, age :: Int}

home = Segment "home"
post = Segment "post"

sperson :: Person -> Tag
sperson (Person name age) = sdiv </> [stitle name, stext $ show age]

stitle :: String -> Tag
stitle text = stext text ! sclass "title" </> [sa [home, post] "post"]

ssite :: Tag -> Tag
ssite tag =
	sdiv ! sclass "main" </>
		[sdiv ! sclass "content" </>
			[tag]]

main = html "5" $
	sdiv ! sid "container" </>
		[sdiv ! sid "container2",
		sdiv ! sid "uuu" </>
			[ssite $ stitle "This is a site - is it?",
			sperson $ Person "John Carmack" 5]]

