module Ex4 where

myOr :: [Bool] -> Bool
myOr []     = False
myOr (x:xs) = x || myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny f l =
    case l of
      []     -> False
      x : _  | f x -> True
      _ : xs -> myAny f xs


myElem :: Eq a => a -> [a] -> Bool
myElem x l =
    myAny (== x) l

myReverse :: [a] -> [a]
myReverse l = go [] l
    where go acc l =
              case l of
                []     -> acc
                x : xs -> go (x : acc) xs


squish :: [[a]] -> [a]
squish []       = []
squish (l : ls) = l ++ squish ls

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap f l =
    case l of
      []      -> []
      (x: xs) -> (f x) ++ squishMap f xs

squishAgain :: [[a]]       -> [a]
squishAgain [] = []
squishAgain l  = squishMap id l


ordHelper :: (a -> a -> Ordering) -> a -> a -> a
ordHelper f a b =
    case f a b of
      GT -> a
      _  -> b

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy f l =
    case l of
      (x : []) -> x
      (x : xs) -> ordHelper f x $ myMaximumBy f xs

