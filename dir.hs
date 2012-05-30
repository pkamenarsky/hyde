module Main where

import System.Directory
import System.Time
import Data.List
import Control.Monad

-- TimeFile

newtype TimeFile = TimeFile {timefile :: (FilePath, ClockTime)} deriving (Show)

filepath = (fst . timefile)
filetime = (snd . timefile)

instance Eq TimeFile where
	(==) a b = filepath a == filepath b

-- Difference

data Difference = Difference {new :: [FilePath], removed :: [FilePath], modified :: [FilePath]} deriving (Show)

difference :: [TimeFile] -> [TimeFile] -> Difference
difference old new =
	Difference
		(map filepath $ new \\ old)
		(map filepath $ old \\ new)
		(map filepath $ intersectBy (\(TimeFile (n, t)) (TimeFile (n', t')) -> n == n' && t /= t') old new)

-- IO

getTimestamps :: FilePath -> IO [TimeFile]
getTimestamps path = do
	let fpath = map ((path ++ "/")++)

	content <- getDirectoryContents path
	files <- filterM doesFileExist $ fpath content
	dirs <- filterM doesDirectoryExist $ fpath $ filter (not . isPrefixOf ".") content

	times <- mapM getModificationTime files
	rtimes <- mapM getTimestamps dirs

	return $ map TimeFile (zip files times) ++ concat rtimes

main = getTimestamps "."

zero = TOD 0 0

prop_oldfiles = difference [TimeFile ("a", zero), TimeFile ("b", zero)] [TimeFile ("a", TOD 0 1)]
