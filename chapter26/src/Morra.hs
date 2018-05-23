module Morra where

import           Control.Applicative
import           Control.Monad
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Maybe
import           Control.Monad.Trans.Reader
import           Control.Monad.Trans.State
import           Data.Maybe
import           Data.Monoid
import           System.Random
-- StateT should save scores of both player and computer
-- Computer should choose its hand randomly
-- When the game exits, it should report the winner

newtype Human = Human (Sum Int)

instance Monoid Human where
  mempty = Human mempty
  (Human h1) `mappend` (Human h2) = Human (h1 `mappend` h2)

newtype AI = AI (Sum Int)

instance Monoid AI where
  mempty = AI mempty
  (AI a1) `mappend` (AI a2) = AI (a1 `mappend` a2)

data Input = Input
  { value :: Int
  , guess :: Int
  } deriving (Eq, Show)

newtype Score = Score (Human, AI)

instance Monoid Score where
  mempty = Score (mempty, mempty)
  (Score (h1, a1)) `mappend` (Score (h2, a2)) =
    Score ((h1 `mappend` h2), (a1 `mappend` a2))

data Winner
  = Humans
  | Computer
  | Drawn
  deriving (Eq, Show)

type Guess = (Input, Input)

readValue :: (Read a) => IO a
readValue = fmap read getLine

shouldQuit :: Char -> Bool
shouldQuit = (==) 'q'

readAiInput :: Int -> Int -> IO Int
readAiInput l h = getStdRandom (randomR (l, h))

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
  c1 <- liftIO $ readAiInput 0 5
  c2 <- liftIO $ readAiInput 5 10
  liftIO $ putStrLn $ "Computer's finger count:" ++ show c1
  liftIO $ putStrLn $ "Computer's guess:" ++ show c2
  return (Input h1 h2, Input c1 c2)

guessToSum :: Guess -> Int
guessToSum = (+) <$> (value . fst) <*> (value . snd)

getScore :: Int -> Int -> Int -> Score
getScore s h a
  | h == s = Score (Human 1, AI 0)
  | a == s = Score (Human 0, AI 1)
  | otherwise = Score (Human 0, AI 0)

play :: MaybeT IO Score
play = do
  g <- go
  let s = guessToSum g
  return $ liftA2 (getScore s) (guess . fst) (guess . snd) $ g

scoreToWinner :: Score -> Winner
scoreToWinner (Score (Human h, AI a))
  | h > a = Humans
  | a > h = Computer
  | otherwise = Drawn

main :: IO String
main = do
  s <- evalStateT go' mempty
  return $ (show . scoreToWinner) s

process :: Score -> Maybe Score -> IO Score
process current maybeNext =
  case maybeNext of
    Just next -> evalStateT go' (current `mappend` next)
    Nothing   -> return current

go' :: StateT Score IO Score
go' = do
  current <- get
  let ir = runMaybeT play
  liftIO $ ir >>= process current
