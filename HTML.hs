module HTML where

import System.IO
import List

-- Combinators

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

-- Attributes

sid = attr "id"
sclass = attr "class"

-- Renderer

renderURL :: URL -> String
renderURL (URL segments) = concat $ intersperse "/" $ map renderURL segments
renderURL (Segment segment) = segment

renderTag :: Tag -> String
renderTag (Tag DivT content [] children) = "<div>\n" ++ concatMap renderTag children ++ content ++ "</div>\n"
renderTag (Tag DivT content attrs children) = "<div " ++ concatMap (\(name, value) -> name ++ "=\"" ++ value ++ "\"") attrs ++ ">\n" ++ content ++ concatMap renderTag children ++ "</div>\n"

renderTag (Tag (AT url) content attrs children) = "<a href=\"" ++ renderURL url ++ "\"" ++ concatMap (\(name, value) -> name ++ "=\"" ++ value ++ "\"") attrs ++ ">" ++ content ++ concatMap renderTag children ++ "</a>\n"

-- HTML

html dtype tag = putStrLn $ "<doctype>" ++ show tag
