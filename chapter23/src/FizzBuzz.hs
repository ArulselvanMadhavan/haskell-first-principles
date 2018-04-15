
module FizzBuzz where
import           Control.Monad
import           Control.Monad.Trans.State
import           Data.Ord

fizzbuzz :: Integer -> String
fizzbuzz n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 5 == 0 = "Buzz"
  | n `mod` 3 == 0 = "Fizz"
  | otherwise = show n


addResult :: Integer -> State [String] ()
addResult n = do
    xs <- get
    let result = fizzbuzz n
    put (result : xs)

fizzbuzzlist :: [Integer] -> [String]
fizzbuzzlist l =
    execState (mapM_ addResult l) []


fizzbuzzFromTo :: Integer -> Integer -> [String]
fizzbuzzFromTo from to =
  case from `compare` to of
    GT -> fizzbuzzlist [from,(from - 1) .. to]
    LT -> fizzbuzzlist [to,(to - 1) .. from]
    EQ -> fizzbuzzlist []


main :: IO ()
-- main = mapM_ (putStrLn . fizzbuzz) [1 .. 100]
main = mapM_ putStrLn $ fizzbuzzFromTo 1 10
