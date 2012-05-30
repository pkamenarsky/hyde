module Main where

import qualified FSWatcher as FSW
import System.Process

compile :: FSW.Difference -> IO ()
compile diff = do
	p <- mapM (\f -> readProcessWithExitCode "runhaskell" [f] "") $ FSW.new diff
	p' <- mapM (\f -> readProcessWithExitCode "runhaskell" [f] "") $ FSW.modified diff
	putStrLn $ concat $ map (\(_, o, e) -> o ++ e) (p ++ p')

main = FSW.poll "site" compile

