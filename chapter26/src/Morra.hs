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

data Input = Input
  { value :: Int
  , guess :: Int
  } deriving (Eq, Show)

type Guess = (Int, Int)

readValue :: (Read a) => IO a
readValue = fmap read getLine

shouldQuit :: Char -> Bool
shouldQuit = (==) 'q'

readAiInput :: IO Int
readAiInput = getStdRandom (randomR (1, 10))

getNext :: String -> [Guess] -> IO [Guess]
getNext h1 xs = do
  c2 <- readAiInput
  return $ (read h1, c2) : xs

checkQuitAndContinue :: String -> Maybe String
checkQuitAndContinue s = undefined

go :: [Guess] -> IO [Guess]
go current = do
  putStr "Enter your finger count(q-quit):"
  v <- getLine
  putStr "Enter your guess:"
  g <- getLine
  if shouldQuit (head v)
    then (return current)
    else (getNext v current) >>= go

main :: IO Int
main = evalStateT go' []

go' :: StateT [Guess] IO Int
go' = do
  s <- get
  ss <- liftIO $ go s
  return $ length ss
