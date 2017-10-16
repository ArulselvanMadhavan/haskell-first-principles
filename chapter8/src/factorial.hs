module Factorial where

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)


sumAll :: (Eq a, Num a) => a -> a
sumAll n = go n 0
    where go x s
              | x == 0 = s
              | otherwise = go (x - 1) (s + x)

multRec :: (Integral a) => a -> a -> a
multRec x y
    | (x == 0 || y == 0) = 0
    | otherwise = go x y
    where go a b
              | a == 1 = b
              | a <= 0 = go (a + 1) b - b
              | a > 0 = b + go (a - 1) b

data DividedResult a =
    Result (a, a)
    | DividedByZero deriving (Show)

divideHelper :: Integral a => a -> a -> a -> (a , a)
divideHelper n d c
    | n < d = (c, n)
    | otherwise = divideHelper (n - d) d (c + 1)

flipArg :: Integral a => (a, a) -> (a, a)
flipArg (x, y) =
    (-x, y)

dividedBy :: Integral a => a -> a -> DividedResult a
dividedBy num denom
    | denom == 0 = DividedByZero
    | num < 0 && denom < 0 = Result $ divideHelper (-num) (-denom) 0
    | num > 0 && denom < 0 = Result . flipArg $ divideHelper num (-denom) 0
    | num < 0 && denom > 0 = Result . flipArg $ divideHelper (-num) denom 0
    | num > 0 && denom > 0 = Result $ divideHelper num denom 0


mc91 :: Integral a => a -> a
mc91 x
    | x <= 100 = x
    | otherwise = x - 10
