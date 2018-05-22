module Morra where
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.State
import           System.Random

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

main :: IO Int
main = evalStateT go' []

type Guess = (Int, Int)

go' :: StateT [Guess] IO Int
go' = do
  s <- get
  ss <- liftIO $ go s
  return $ length ss
