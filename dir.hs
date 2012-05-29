module Main where

import System.Directory
import System.Time
import qualified Data.Set as Set

newtype TimeFile = TimeFile (FilePath, ClockTime)

data Difference = Difference {new :: [FilePath], removed :: [FilePath], modified :: [FilePath]} deriving (Show)

difference :: [TimeFile] -> [TimeFile] -> Difference
difference old new = let
						oldNames = Set.fromList $ map (\(TimeFile (path, _)) -> path) old
						newNames = Set.fromList $ map (\(TimeFile (path, _)) -> path) new
					in Difference (diff newNames oldNames) (diff oldNames newNames) [] where
						diff a b = Set.toList $ Set.difference a b

getTimestamps :: FilePath -> IO [TimeFile]
getTimestamps path = do
	files <- getDirectoryContents path
	times <- mapM getModificationTime files
	return $ map TimeFile $ zip files times

main = getTimestamps "."

zero = TOD 0 0

prop_oldfiles = difference [TimeFile ("a", zero), TimeFile ("b", zero)] [TimeFile ("a", zero)]
