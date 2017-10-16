module Palindrome where

rvrs :: [a] -> [a]
rvrs [] = []
rvrs (x : xs) = x : rvrs xs


isPalindrome :: Eq a => [a] -> Bool
isPalindrome x =
  (reverse x) == x

myabs :: Integer -> Integer
myabs x = if x < 0 then (-x) else x

flp :: (a, b) -> (c, d) -> ((b, d), (a, c))
flp x y = ((snd x, snd y), (fst x, fst y))

par :: a -> a -> a
par a1 a2 =
  a1

par2 :: a -> a -> a
par2 a1 a2 =
  a2
