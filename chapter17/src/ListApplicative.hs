module ListApplicative where

import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

data List a
  = Nil
  | Cons a
         (List a)
  deriving (Eq, Show)

instance Functor List where
  fmap _ Nil         = Nil
  fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List where
  pure a = Cons a Nil
  (<*>) fs ls = flatMap ((flip fmap) ls) fs

instance Eq a => EqProp (List a) where
  (=-=) = eq

instance Arbitrary a => Arbitrary (List a) where
  arbitrary = sized arbitraryList

-- https://stackoverflow.com/questions/45592769/instance-of-arbitrary-for-custom-list-like-type
arbitraryList :: Arbitrary a => Int -> Gen (List a)
arbitraryList m
  | m == 0 = return Nil
  | m < 6 = Cons <$> arbitrary <*> arbitraryList (m - 1) --To Prevent long runnign tests.
  | otherwise = Cons <$> arbitrary <*> arbitraryList 5

append :: List a -> List a -> List a
append Nil ys         = ys
append (Cons x xs) ys = Cons x (append xs ys)

fold :: (a -> b -> b) -> b -> List a -> b
fold _ b Nil         = b
fold f b (Cons x xs) = f x (fold f b xs)

concat' :: List (List a) -> List a
concat' = fold append Nil

flatMap :: (a -> List b) -> List a -> List b
flatMap f as = concat' $ fmap f as

take' :: Int -> List a -> List a
take' _ Nil = Nil
take' n (Cons x xs)
  | n == 0 = Nil
