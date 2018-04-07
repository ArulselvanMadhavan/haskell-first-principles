module ReaderPractice where

import           Control.Applicative
import           Data.Maybe

x = [1, 2, 3]
y = [4, 5, 6]
z = [7, 8, 9]

findVal :: (Eq a) => a -> (a, b) -> Maybe b -> Maybe b
findVal k ab b =
    if (k == fst ab) then Just (snd ab) else b

lookup' :: Eq a => a -> [(a, b)] -> Maybe b
lookup' k =
    foldr (findVal k) Nothing

xs :: Maybe Integer
xs = lookup' 3 (zip x y)

ys :: Maybe Integer
ys = lookup' 6 $ zip y z

zs :: Maybe Integer
zs = lookup' 4 $ zip x y

z' :: Integer -> Maybe Integer
z' n = lookup' n $ zip x y

x1 :: Maybe (Integer, Integer)
x1 = liftA2 (,) xs ys

x2 :: Maybe (Integer, Integer)
x2 = liftA2 (,) ys zs

x3 :: Integer -> (Maybe Integer, Maybe Integer)
x3 n = (,) (z' n) (z' n)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f ab = f (fst ab) (snd ab)

summed :: Num c => (c, c) -> c
summed = uncurry' (+)

bolt :: Integer -> Bool
bolt = liftA2 (&&) (> 3) (< 8)

fromMaybe' :: a -> Maybe a -> a
fromMaybe' a ma = foldr (\a1 _ -> a1) a ma

sequA :: Integer -> [Bool]
sequA = sequenceA [(>3), (<8), even]

main :: IO ()
main = do
  print $ sequenceA [Just 3, Just 2, Just 1]
  print $ sequenceA [x, y]
  print $ summed <$> ((,) <$> xs <*> ys)
  print $ fmap summed ((,) <$> xs <*> zs)
  print $ bolt 7
  print $ fmap bolt z
  print $ sequenceA [(>3), (<8), even] 7
  print $ foldr (&&) True $ sequA 7
  print $ sequA . fromMaybe' 0 $ ys
  print $ bolt . fromMaybe' 0 $  ys
