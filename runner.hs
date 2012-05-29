module Main where

import System.Directory (getModificationTime, doesDirectoryExist, getDirectoryContents)

import System.Hiernotify.Polling
import Control.Concurrent
import Control.Monad

main = do
	time <- getModificationTime "html.hs"
	print $ show time
	poll <- mkPollNotifier 1 Configuration {top = ".", silence = 1, select = \_ -> True}
	pr <- forkIO $ forever $ do
		diff <- difference poll
		print diff
	threadDelay 100000
	stop poll
	killThread pr
