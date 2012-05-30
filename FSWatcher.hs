module FSWatcher where

import System.Directory
import System.Time
import Data.List
import Control.Monad
import Control.Concurrent

import Test.QuickCheck

-- TimeFile

newtype TimeFile = TimeFile {timefile :: (FilePath, ClockTime)} deriving (Show)

filepath = (fst . timefile)
filetime = (snd . timefile)

instance Eq TimeFile where
	(==) a b = filepath a == filepath b

-- Difference

data Difference = Difference {new :: [FilePath], removed :: [FilePath], modified :: [FilePath]} deriving (Eq, Show)

difference :: [TimeFile] -> [TimeFile] -> Difference
difference old new =
	Difference
		(map filepath $ new \\ old)
		(map filepath $ old \\ new)
		(map filepath $ intersectBy (\(TimeFile (n, t)) (TimeFile (n', t')) -> n == n' && t /= t') old new)

nullDiff (Difference new removed modified) = null new && null removed && null modified

-- IO

getTimestamps :: FilePath -> IO [TimeFile]
getTimestamps path = do
	let fpath = map ((path ++ "/") ++)

	content <- getDirectoryContents path
	files <- filterM doesFileExist $ fpath content
	dirs <- filterM doesDirectoryExist $ fpath $ filter (not . isPrefixOf ".") content

	times <- mapM getModificationTime files
	rtimes <- mapM getTimestamps dirs

	return $ map TimeFile (zip files times) ++ concat rtimes

pollR :: String -> [TimeFile] -> Difference -> (Difference -> IO ()) -> IO ()
pollR path files diff action = do
	files' <- getTimestamps path
	let diff' = difference files files'

	when ((not . nullDiff) diff' && diff /= diff') (action diff')

	threadDelay 1000000
	pollR path files' diff' action

poll :: Bool -> String -> (Difference -> IO ()) -> IO ()
poll initial path action = do
	files <- getTimestamps path
	when initial $ action $ Difference (map filepath files) [] []
	pollR path files (Difference [] [] []) action

-- Tests

instance Arbitrary ClockTime where
	arbitrary = liftM2 TOD arbitrary arbitrary

instance Arbitrary TimeFile where
	arbitrary = do
					name <- arbitrary
					time <- arbitrary
					return $ TimeFile (name, time)

prop_difference :: [TimeFile] -> [TimeFile] -> Bool
prop_difference a b = (n == o' && n' == o && m == m') where
	a' = nub a
	b' = nub b
	(Difference n o m) = difference a' b'
	(Difference n' o' m') = difference b' a'
