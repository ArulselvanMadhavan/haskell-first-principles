module FixTheCode where

import           Control.Monad
import           Control.Monad.Trans.Maybe

isValid :: String -> Bool
isValid v = '!' `elem` v

maybeExcite :: MaybeT IO String
maybeExcite =
  MaybeT $ do
    v <- getLine
    guard $ isValid v
    return $ Just v

doExcite :: IO ()
doExcite = do
  putStrLn "say something excite!"
  excite <- runMaybeT maybeExcite
  case excite of
    Nothing -> putStrLn "Moar Excite"
    Just e  -> putStrLn ("Good, was very excite: " ++ e)
