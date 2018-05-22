module Morra where
import System.Random
import Control.Monad.Trans.State

-- StateT should save scores of both player and computer
-- Computer should choose its hand randomly
-- When the game exits, it should report the winner

data Winner
  = Human
  | AI
  deriving (Eq, Show)

readValue :: (Read a) => IO a
readValue = fmap read getLine

shouldQuit :: Char -> Bool
shouldQuit c = if c == 'q' then True else False

readAiInput :: IO Int
readAiInput = getStdRandom (randomR (1, 10))
    
isContinue :: String -> Bool
isContinue i =
    if i == "n" then True else False

getNext :: String -> [(Int, Int)] -> IO [(Int, Int)]
getNext h1 xs = do
  c2 <- readAiInput
  return $ (read h1, c2) : xs

go :: [(Int, Int)] -> IO [(Int, Int)]
go current = do
  putStr "Enter your finger count(q-quit):"
  v <- getLine
  if shouldQuit (head v)
    then (return current)
    else (getNext v current) >>= go
        
main :: IO [(Int, Int)]
main = go []

type Guess = (Int, Int)

-- main :: StateT [Guess] IO Int
-- main = do
    
