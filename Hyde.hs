module Main where

import System.IO
import System.Directory

import Maybe
import Data.List
import System.Process
import Control.Monad
import qualified FSWatcher as FSW

-- Configuration

dirIn = "site"
dirOut = "out"

suffixIn = ".hs"
suffixOut = ".html"

-- Compilation

stripSuffix suffix xs = do
	xs' <- stripPrefix (reverse suffix) (reverse xs)
	return $ reverse xs'

compile :: FSW.Difference -> IO ()
compile diff = do
	createDirectoryIfMissing True dirOut

	let infiles = filter (isSuffixOf suffixIn) (FSW.new diff ++ FSW.modified diff)
	let outfiles = map ((dirOut ++) . fromJust . (stripPrefix dirIn) . 
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

main = FSW.poll dirIn compile
