module Site.Philosophy where

import System.IO
import Global.Site
import Prelude hiding (div)
import HTML

intro = "When it comes to developing software it is important to choose the proverbial right tool for the job. We are well versed in mainstream languages, like C / C++, Java, PHP or Ruby and have worked on both small and large codebases using those. That said, if we are let to decide, we prefer functional languages -- specifically Clojure, Erlang and Haskell, depending on the project domain. We believe that those platforms allow for a more composable, robust and testable way of building software, resulting in fewer bugs and both smaller dev*-elopment and maintenance costs."
erlangDesc = "<b>Erlang</b> is a dynamic industrial language specifically aimed at efficient development of competitive high avail*-ability systems. Its features make it possible to upgrade live services without interruption, ensuring minimum downtime; it allows for transparent scalability and distribution and its sophisticated supervision and error han*-dling facilities make it the obvious choice for building fault tolerant, reliable platforms. - notable users: Goldman Sachs, Amazon, T-Mobile, Motorola"
haskellDesc = "<b>Haskell</b> is a mind bending, statically typed purely-functional language; it has a diverse range of use com*-mer*-cially, from aerospace and defense, to finance and hardware design firms. An open-source product of more than twenty years of cutting-edge research, it allows rapid development of robust, concise and correct soft*-ware. - notable users: Credit Suisse, AT&T, Deutsche Bank, Google"
clojureDesc = "<b>Clojure</b> is a functional dynamic programming language that targets the Java Virtual Machine; as a dialect of Lisp it shares its code-as-data philosophy and powerful macro system. It specifically shines in areas of sym*-bolic data manipulation with a flexible or no model structure, logic programming and concurrent designs, due to its elegant software transactional memory implementation. - notable users: CitiGroup, ..."

main = do
	copy <- readFile "Global/dev2.html"

	site 1 1 $ div </>
		[title "Choosing the right technology",
		pitch "tool.png" intro,
		pitch "erlang.png" erlangDesc,
		pitch "haskell.png" haskellDesc,
		pitch "clojure.png" clojureDesc]
