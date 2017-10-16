module Arith2 where

add :: Int -> Int -> Int
add x y =
    x + y

addPF :: Int -> Int -> Int
addPF = (+)

addOne :: Int -> Int
addOne = \x -> x + 1

addOnePF :: Int -> Int
addOnePF = (+1)


-- main :: IO()
-- main = do
--     print (0 :: Int)
--     print (add 1 0)
--     print (addOne 0)
--     print (addOnePF 0)
--     print ((addOne . addOne) 0)
--     print ((addOnePF . addOne) 0)
--     print ((addOne . addOnePF) 0)
--     print ((addOnePF . addOnePF) 0)
--     print (negate (addOne 0))
--     print ((negate . addOne) 0)
--     print ((addOne . addOne . addOne . negate . addOne) 0)


tensDigit :: Integral a => a -> a
tensDigit x = d
    where xLast = x `div` 10
          d = xLast `mod` 10

tensDigitMod :: Integral a => a -> a
tensDigitMod x =
    let flipX = flip divMod 10
        modX = flip mod 10 in
      (modX . fst . flipX) x

hunsD :: Integral a => a -> a
hunsD x =
    flip mod 10 . fst . flip divMod 100 $ x

foldBool :: a -> a -> Bool -> a
foldBool x y bool =
    case bool of
      True  -> x
      False -> y

foldBool3 :: a -> a -> Bool -> a
foldBool3 x y bool
    | bool = x
    | otherwise = y

g :: (a -> b) -> (a, c) -> (b, c)
g f t =
    (f . fst $ t, snd t)

roundTrip :: (Show a, Read b) => a -> b
roundTrip = read . show

main = do
    print (roundTrip 4 :: Double)
    print (id 4)
