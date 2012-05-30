module HTML where

import Prelude hiding (div, Left)
import System.IO
import Numeric (showHex)
import List

-- Combinators

data URL = URL String

instance Show URL where
	show (URL url) = url

data Doctype = HTML5 | HTML4
data Include = Script URL | CSS URL
data Unit = Px | Pct | Pt
data PositionV = Absolute | Relative | Static
data StyleRule = Position PositionV |
	Left Int Unit | Top Int Unit | Width Integer Unit | Height Int Unit |
	BGColor Int

data Attr = Id String | Class String | Classes [String] | Style [StyleRule] | Href URL | Src URL
data Tag = Tag {tag :: String, content :: String, attributes :: [Attr], children :: [Tag]}

instance Show Tag where
	show = renderTag

(</>) :: Tag -> [Tag] -> Tag
(</>) tag children = tag {children = children}
infixr 5 </>

(!) :: Tag -> Attr -> Tag
(!) tag attr = tag {attributes = attr : (attributes tag)} 

(<+>) :: (Show a, Show b) => a -> b -> URL
(<+>) a b = URL $ show a ++ "/" ++ show b

-- Tags

body = Tag "body" "" [] []
div = Tag "div" "" [] []
divText text = Tag "div" text [] []
span = Tag "span" "" [] []
text text = Tag "span" text [] []
a text url = Tag "a" text [Href url] []
img url = Tag "img" "" [Src url] []

-- Renderers

renderUnit :: Unit -> String
renderUnit Px = "px"
renderUnit Pct = "%"
renderUnit Pt = "pt"

renderStyleRule :: StyleRule -> String
renderStyleRule (Position Absolute) = "position: absolute"
renderStyleRule (Position Relative) = "position: relative"
renderStyleRule (Position Static) = "position: static"
renderStyleRule (Left x unit) = "left: " ++ show x ++ renderUnit unit
renderStyleRule (Top x unit) = "top: " ++ show x ++ renderUnit unit
renderStyleRule (Width x unit) = "width: " ++ show x ++ renderUnit unit
renderStyleRule (Height x unit) = "height: " ++ show x ++ renderUnit unit
renderStyleRule (BGColor c) = "background-color: #" ++ showHex c ""

renderAttr :: Attr -> String
renderAttr (Id id) = "id=\"" ++ id ++ "\" "
renderAttr (Src url) = "src=\"" ++ show url ++ "\" "
renderAttr (Href url) = "href=\"" ++ show url ++ "\" "
renderAttr (Class c) = "class=\"" ++ c ++ "\" " 
renderAttr (Classes cs) = "class=\"" ++ concat (intersperse "; " cs) ++ "\" " 
renderAttr (Style rules) = "style=\"" ++ concat (intersperse "; " $ map renderStyleRule rules) ++ "\" " 

renderDoctype :: Doctype -> String
renderDoctype HTML5 = "<!doctype html>\n"
renderDoctype HTML4 = "<!doctype html public \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n"

renderInclude :: Include -> String
renderInclude (Script url) = "<script type=\"text/javascript\" src=\"" ++ show url ++ "\"></script>\n"
renderInclude (CSS url) = "<link rel=\"stylesheet\" type=\"text/css\" href=\"" ++ show url ++ "\"></link>\n"

-- renderURL :: URL -> String
-- renderURL (URL a b) = renderURL a ++ "/" ++ renderURL b
-- renderURL (Segment url) = url

renderTag :: Tag -> String
renderTag (Tag tag content attrs children) = "<" ++ tag ++ " " ++ concatMap renderAttr attrs ++ ">\n" ++ content ++ concatMap renderTag children ++ "</" ++ tag ++ ">\n"

-- HTML

html :: Doctype -> [Include] -> Tag -> IO ()
html dtype includes tag = putStrLn $ renderDoctype dtype ++ concatMap renderInclude includes ++ show tag

-- Utils

vGrid height count = div ! Style [Position Absolute, Width 100 Pct, Height 100 Pct] </>
	map (\y -> div ! Style
			[Position Absolute, BGColor 0xffeeee, Width 100 Pct, Height height Px, Top (y * height * 2) Px])
		[0..count]
