module KleisliExample where

import           Control.Monad ((>=>))

sayHi :: String -> IO String
sayHi txt = do
  putStrLn txt
  getLine

readM :: Read a => String -> IO a
readM = return . read

getAge :: String -> IO Int
getAge = sayHi >=> readM

askForAge :: IO Int
askForAge = getAge "Hello! How old are you?"
