module HTML where

import Prelude hiding (Left)
import System.IO
import Numeric (showHex)
import List

-- Combinators

data Doctype = HTML5 | HTML4

data URL = URL [URL] | Segment String deriving (Show)

data Include = Script URL | CSS URL

data Unit = Px | Pct | Pt
data PositionV = Absolute | Relative | Static

data StyleRule = Position PositionV |
	Left Int Unit | Top Int Unit | Width Integer Unit | Height Int Unit |
	BGColor Int
data Attr = Id String | Class String | Classes [String] | Style [StyleRule]

data TagT = BodyT | SpanT | DivT | AT URL | ImgT URL deriving (Show)
data Tag = Tag {tag :: TagT, content :: String, attributes :: [Attr], children :: [Tag]}

instance Show Tag where
	show = renderTag

body = Tag BodyT "" [] []
div = Tag DivT "" [] []
divText text = Tag DivT text [] []
span = Tag SpanT "" [] []
text text = Tag SpanT text [] []

a :: [URL] -> String -> Tag
a urls text = Tag (AT $ URL urls) text [] []

img :: String -> Tag
img url = Tag (ImgT $ Segment url) "" [] []

(</>) :: Tag -> [Tag] -> Tag
(</>) tag children = tag {children = children}
infixr 5 </>

(!) :: Tag -> Attr -> Tag
(!) tag attr = tag {attributes = attr : (attributes tag)} 

-- Renderer

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
renderAttr (Class c) = "class=\"" ++ c ++ "\" " 
renderAttr (Classes cs) = "class=\"" ++ concat (intersperse "; " cs) ++ "\" " 
renderAttr (Style rules) = "style=\"" ++ concat (intersperse "; " $ map renderStyleRule rules) ++ "\" " 

renderDoctype :: Doctype -> String
renderDoctype HTML5 = "<!doctype html>\n"
renderDoctype HTML4 = "<!doctype html public \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n"

renderInclude :: Include -> String
renderInclude (Script url) = "<script type=\"text/javascript\" src=\"" ++ renderURL url ++ "\"></script>\n"
renderInclude (CSS url) = "<link rel=\"stylesheet\" type=\"text/css\" href=\"" ++ renderURL url ++ "\"></link>\n"

renderURL :: URL -> String
renderURL (URL segments) = concat $ intersperse "/" $ map renderURL segments
renderURL (Segment segment) = segment

renderTag :: Tag -> String

-- body
renderTag (Tag BodyT content attrs children) = "<body " ++ concatMap renderAttr attrs ++ ">\n" ++ content ++ concatMap renderTag children ++ "</body>\n"

-- span
renderTag (Tag SpanT content attrs children) = "<span " ++ concatMap renderAttr attrs ++ ">\n" ++ content ++ concatMap renderTag children ++ "</span>\n"

-- div
renderTag (Tag DivT content attrs children) = "<div " ++ concatMap renderAttr attrs ++ ">\n" ++ content ++ concatMap renderTag children ++ "</div>\n"

-- a
renderTag (Tag (AT url) content attrs children) = "<a href=\"" ++ renderURL url ++ "\"" ++ concatMap renderAttr attrs ++ ">" ++ content ++ concatMap renderTag children ++ "</a>\n"

-- img
renderTag (Tag (ImgT url) _ _ _) = "<img src=\"" ++ renderURL url ++ "\">\n"

-- HTML

html :: Doctype -> [Include] -> Tag -> IO ()
html dtype includes tag = putStrLn $ renderDoctype dtype ++ concatMap renderInclude includes ++ show tag
