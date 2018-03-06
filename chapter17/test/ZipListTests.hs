module ZipListTests where

import           Control.Applicative
import           Data.Monoid
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

data List a
  = Nil
  | Cons a
         (List a)
  deriving (Eq, Show)

take' :: Int -> List a -> List a
take' _ Nil = Nil
take' n (Cons x xs)
  | n == 0 = Nil
  | otherwise = Cons x (take' (n - 1) xs)


instance Functor List where
  fmap _ Nil         = Nil
  fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List where
  pure a = Cons a Nil
  (<*>) fs ls = flatMap ((flip fmap) ls) fs

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

newtype ZipList' a =
    ZipList' (List a)
    deriving (Eq, Show)

instance Eq a => EqProp (ZipList' a) where
    xs =-= ys = xs' `eq` ys'
      where xs' = let (ZipList' l) = xs
                    in take' 3000 l
            ys' = let (ZipList' l) = ys
                    in take' 3000 l

instance Functor ZipList' where
    fmap f (ZipList' xs) =
        ZipList' $ fmap f xs

--There has to be a better way to do this.
addToHead :: (a -> b) -> a -> ZipList' b -> ZipList' b
addToHead f x (ZipList' xs) =
    ZipList' (Cons (f x) xs)

instance Applicative ZipList' where
    pure a = ZipList' (pure a)
    (<*>) (ZipList' Nil) _                              = ZipList' Nil
    (<*>) _ (ZipList' Nil)                              = ZipList' Nil
    (<*>) (ZipList' (Cons f fs)) (ZipList' (Cons x xs)) = addToHead f x ((ZipList' fs) <*> (ZipList' xs))
