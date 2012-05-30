module Main where

import System.IO
import System.Directory

import Maybe
import Data.List
import Data.Char
import System.Process
import Control.Monad
import Control.Concurrent
import qualified FSWatcher as FSW

-- Configuration

dirIn = "Site"
dirGlobal = "Global"
dirOut = "out"

suffixIn = ".hs"
suffixOut = ".html"

-- Compilation

stripSuffix suffix xs = do
	xs' <- stripPrefix (reverse suffix) (reverse xs)
	return $ reverse xs'

compile :: FSW.Difference -> IO ()
compile diff = do
	let infiles = filter (isSuffixOf suffixIn) (FSW.new diff ++ FSW.modified diff)
	let outfiles = map ((dirOut ++) . (map toLower) . fromJust . (stripPrefix dirIn) . 
		(++ suffixOut) . fromJust . (stripSuffix suffixIn)) infiles

	putStr "Generating markup..."
	hFlush stdout
	out <- mapM (\f -> readProcessWithExitCode "runhaskell" [f] "") infiles

	let (success, error) = partition (\(_, (_, _, e)) -> null e) (zip outfiles out)
	case error of
		[] -> putStrLn " done"
		_ -> putStrLn " encountered errors:"

	-- print errors
	when (not . null $ error) $ putStrLn $ concat $ map (\(_, (_, _, e)) -> e) error

	-- write generated output
	when (not . null $ success) $ mapM_ (\(f, (_, o, _)) -> writeFile f o) success

compileAll :: FSW.Difference -> IO ()
compileAll _ = do
	files <- FSW.getTimestamps dirIn
	compile $ FSW.Difference (map FSW.filepath files) [] []

main = do
	createDirectoryIfMissing True dirIn
	createDirectoryIfMissing True dirGlobal
	createDirectoryIfMissing True dirOut

	forkIO $ FSW.poll False dirGlobal compileAll
	FSW.poll True dirIn compile
