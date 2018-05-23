module Morra where
import           Control.Monad
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Maybe
import           Control.Monad.Trans.Reader
import           Control.Monad.Trans.State
import           System.Random
-- StateT should save scores of both player and computer
-- Computer should choose its hand randomly
-- When the game exits, it should report the winner

newtype Human = Human Int
newtype AI = AI Int


data Input = Input
  { value :: Int
  , guess :: Int
  } deriving (Eq, Show)

type Score = (Human, AI)
type Guess = (Input, Input)

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

go :: MaybeT IO Guess
go = do
  liftIO $ putStr "Enter your finger count(q-quit):"
  h1 <- MaybeT (fmap (stringToInt . checkQuitAndContinue) getLine)
  liftIO $ putStr "Enter your guess:"
  h2 <- liftIO (fmap read getLine)
  c1 <- liftIO $ readAiInput 5
  c2 <- liftIO $ readAiInput 10
  return (Input h1 h2, Input c1 c2)

guessToSum :: Guess -> Int
guessToSum = (+) <$> (value . fst) <*> (value . snd)

getScore :: Int -> Score
getScore s
    | s < 0 = (Human 1, AI 0)
    | otherwise = (Human 0, AI 0)

toResult :: MaybeT IO Score
toResult = do
    g <- go
    let s = guessToSum g
    let h = snd g
    let c = snd g
    return s
        -- | h == sum = (Human 1, AI 0)
        -- | c == sum = (Human 0, AI 1)
        -- | otherwise = (Human 0, AI 0)

main :: IO Int
main = evalStateT go' (Human 0, AI 0)

go' :: StateT Score IO Int
go' = do
  s <- get
  let ir = go
  ss <- liftIO $ go
  return $ length ss
