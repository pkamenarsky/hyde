module Main where

import System.Directory
import System.Time
import Data.List

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
		[]

getTimestamps :: FilePath -> IO [TimeFile]
getTimestamps path = do
	files <- getDirectoryContents path
	times <- mapM getModificationTime files
	return $ map TimeFile $ zip files times

main = getTimestamps "."

zero = TOD 0 0

prop_oldfiles = difference [TimeFile ("a", zero), TimeFile ("b", zero)] [TimeFile ("a", zero)]
