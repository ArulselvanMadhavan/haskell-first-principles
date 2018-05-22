module Morra where
import           Control.Monad
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Maybe
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

readAiInput :: Int -> IO Int
readAiInput i = getStdRandom (randomR (1, i))

checkQuitAndContinue :: String -> Maybe String
checkQuitAndContinue ('q' : _) = Nothing
checkQuitAndContinue s         = Just s

stringToInt :: Maybe String -> Maybe Int
stringToInt = fmap read

go :: MaybeT IO (Input, Input)
go = do
  liftIO $ putStr "Enter your finger count(q-quit):"
  h1 <- MaybeT (fmap (stringToInt . checkQuitAndContinue) getLine)
  liftIO $ putStr "Enter your guess:"
  h2 <- liftIO (fmap read getLine)
  c1 <- liftIO $ readAiInput 5
  c2 <- liftIO $ readAiInput 10
  return (Input h1 h2, Input c1 c2)

main :: IO Int
main = evalStateT go' []

go' :: StateT [Guess] IO Int
go' = do
  s <- get
  ss <- liftIO $ go s
  return $ length ss
