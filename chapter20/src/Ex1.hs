module Ex1 where
import           Data.Monoid

sum :: (Foldable t, Num a) => t a -> a
sum =
    getSum . (foldMap Sum)

product :: (Foldable t, Num a) => t a -> a
product =
    getProduct . (foldMap Product)

elem :: (Foldable t, Eq a) => a -> t a -> Bool
elem x t =
  foldr
    (\a ->
       \b ->
         if (a == x)
           then True
           else b)
    False
    t

combiner :: (Ord a) => (a -> a -> a) -> a -> Maybe a -> Maybe a
combiner f a Nothing    = Just a
combiner f a1 (Just a2) = Just $ f a1 a2

minimum :: (Foldable t, Ord a) => t a -> Maybe a
minimum t =
    foldr (combiner min) Nothing t

maximum :: (Foldable t, Ord a) => t a -> Maybe a
maximum t =
    foldr (combiner max) Nothing t

checkNull :: (Foldable t) => t a -> t a -> Bool
checkNull = undefined

null :: (Foldable t) => t a -> Bool
null =
    foldr (\_ -> \_ -> False) True

length :: (Foldable t) => t a -> Int
length =
    foldr (\_ -> \b -> b + 1) 0

toList :: (Foldable t) => t a -> [a]
toList =
    foldr (:) []

fold :: (Foldable t, Monoid m) => t m -> m
fold =
    foldMap id

foldMap' :: (Foldable t, Monoid m) => (a -> m) -> t a -> m
foldMap' f t = foldr (\a -> \b -> mappend (f a) b) (mempty) t
