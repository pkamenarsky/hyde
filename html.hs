module Html where

import List

data Template a = Template {runTemplate :: a -> Html}

data Html = Html [Html] | Div String [Html] | Span String | H1 String

-- instance Monad Template where
--	return f = Template $ \a -> f a
--	mv >>= f = Template $ \c -> Div [f c, runTemplate mv]

render :: Html -> String
render (Html children) = "<html>" ++ (concatMap render children) ++ "</html>" 
render (Div id children) = "<div id='" ++ id ++ "'>" ++ (concatMap render children) ++ "</div>"
render (Span text) = "<span>" ++ text ++ "</span>"
render (H1 text) = "<h1>" ++ text ++ "</h1>"

data PositionP = Absolute | Relative | Static | Fixed
data ColorP = ColorP Integer Integer Integer
data Unit = Px | Pct | Pt

data Property = Property Property Property | Position PositionP | Color ColorP | Width Integer Unit |
	Height Integer Unit | Left Integer Unit | Top Integer Unit | Right Integer Unit |
	Bottom Integer Unit
data Rule = Rule [Property]
data Css = Css [Rule]

instance Show Property where
	show = renderP

renderP :: Property -> String
renderP (Property p1 p2) = renderP p1 ++ ";" ++ renderP p2
renderP (Position Absolute) = "position: absolute"
renderP (Position Relative) = "position: relative"
renderP (Position Static) = "position: static"

renderR :: Rule -> String
renderR (Rule properties) = "{" ++ concat (intersperse ";" (map renderP properties)) ++ "}"

renderCss :: Css -> String
renderCss (Css rules) = concatMap renderR rules

--- Combinators

data CHtml = CHtml {runHtml :: String}

hdiv :: String -> [CHtml] -> CHtml
hdiv id children = CHtml $ "<div id='" ++ id ++ "'>" ++ concatMap runHtml children ++ "</div>"

data CRule = CRule {runRule :: (String, String)}

rule :: String -> CRule
rule name = CRule (name, "")

position :: PositionP -> CRule -> CRule
position Absolute rule = let (name, text) = runRule rule in
							CRule $ (name, text ++ "position: absolute;")
position Relative rule = let (name, text) = runRule rule in
							CRule $ (name, text ++ "position: relative;")

runCss :: [CRule] -> String
runCss rules = concatMap (\(CRule (name, text)) -> name ++ " {" ++ text ++ "}") rules

--- Js

data Js = SValue String | IValue Integer | Var String Js | Defn String [String] [Js] | Invoke String [Js] | For String Js Js Js [Js] | JLess Js Js | JIncr Js

renderJs :: Js -> String
renderJs (SValue value) = value
renderJs (IValue value) = show value
renderJs (Var name js) = "var " ++ name ++ "=" ++ renderJs js ++ ";"
renderJs (Defn name args body) = "function " ++ name ++ "(" ++ concat (intersperse ", " args) ++ ") {" ++ concatMap renderJs body ++ "}"
renderJs (Invoke name args) = name ++ "(" ++ concatMap renderJs args ++ ");"
renderJs (For i start test incr body) = "for(" ++ i ++ "=" ++ renderJs start ++ ";" ++ renderJs test ++ ";" ++ renderJs incr ++ ") {" ++ concatMap renderJs body ++ "}"
renderJs (JLess e1 e2) = renderJs e1 ++ "<" ++ renderJs e2
renderJs (JIncr expr) = renderJs expr ++ "++"

--- Application

absolute :: Rule -> Rule
absolute (Rule properties) = Rule $ Position Absolute : properties

title :: String -> Html
title text = Div "" [H1 text]

main6 = print $ renderJs $
	Defn "main" ["argc", "argv"]
		[Var "i" $ IValue 6,
		Var "j" $ IValue 0,
		For "i" (IValue 0) (JLess (SValue "i") (IValue 10)) (JIncr (SValue "i"))
			[Invoke "alert" [(SValue "i")]]]

main5 = print $ runCss [position Absolute . position Relative $ rule "div"]

main4 = print $ runHtml $ hdiv "container" [hdiv "child1" [], hdiv "child2" []]

main3 = print $ renderCss $ Css
	[absolute $ Rule
		[Position Absolute,
		Position Static]]

main2 = print $ render $
	let color = "#ffffff" in
	Html
		[Div "container"
			[title "LALAL", Span color]]

-- Combinators2

data URL = URL [URL] | Segment String deriving (Show)

data TagT = DivT | SpanT | AT URL deriving (Show)
data Tag = Tag {tag :: TagT, content :: String, attributes :: [(String, String)], children :: [Tag]}

instance Show Tag where
	show = renderTag

sdiv = Tag DivT "" [] []
stext text = Tag DivT text [] []

sa :: [URL] -> String -> Tag
sa urls text = Tag (AT $ URL urls) text [] []

attr :: String -> String -> Tag -> Tag
attr name value tag = tag {attributes = (name, value) : (attributes tag)} 

(</>) :: Tag -> [Tag] -> Tag
(</>) tag children = tag {children = children}

(!) :: Tag -> (Tag -> Tag) -> Tag
(!) tag f = f tag

(&) :: Property -> Property -> Property
(&) p1 p2 = Property p1 p2

-- Attributes

sid = attr "id"
sclass = attr "class"
sstyle style = attr "style" (renderP style)

-- Renderer

renderURL :: URL -> String
renderURL (URL segments) = concat $ intersperse "/" $ map renderURL segments
renderURL (Segment segment) = segment

renderTag :: Tag -> String
renderTag (Tag DivT content [] children) = "<div>" ++ concatMap renderTag children ++ content ++ "</div>"
renderTag (Tag DivT content attrs children) = "<div " ++ concatMap (\(name, value) -> name ++ "=\"" ++ value ++ "\"") attrs ++ ">" ++ content ++ concatMap renderTag children ++ "</div>"

renderTag (Tag (AT url) content attrs children) = "<a href=\"" ++ renderURL url ++ "\"" ++ concatMap (\(name, value) -> name ++ "=\"" ++ value ++ "\"") attrs ++ ">" ++ content ++ concatMap renderTag children ++ "</a>"

-- main

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

main100 = print $
	Position Absolute &
	Position Relative &
	Position Static

main = print $
	sdiv ! sid "container" </>
		[sdiv ! sid "container2",
		sdiv ! sid "uuu" ! sstyle (Position Absolute & Position Relative) </>
			[ssite $ stitle "LALAL",
			sperson $ Person "John" 5]]
