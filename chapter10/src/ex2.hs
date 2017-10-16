module Ex2 where

myOr :: [Bool] -> Bool
myOr =
    foldr (||) False

myAny :: (a -> Bool) -> [a] -> Bool
myAny f =
    foldr (\x acc -> f x || acc) False


myElem :: Eq a => a -> [a] -> Bool
myElem y =
    foldr (\x acc -> x == y || acc) False

myElem2 :: Eq a => a -> [a] -> Bool
myElem2 y =
    myAny (== y)

myReverse :: [a] -> [a]
myReverse =
    foldl (flip (:)) []

myMap :: (a -> b) -> [a] -> [b]
myMap f =
    foldr (\x acc -> f x : acc) []

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f =
    foldr (\x acc -> if f x then x : acc else acc) []

squish :: [[a]] -> [a]
squish =
    foldr (++) []

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f =
    foldr (\x acc -> f x ++ acc) []

squishAgain :: [[a]] -> [a]
squishAgain =
    squishMap id

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy f xs =
    foldr (\x acc -> (case f x acc of
                        GT -> x
                        _  -> acc)) (head xs) (tail xs)


