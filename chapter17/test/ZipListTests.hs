module ZipListTests where

import           Control.Applicative
import           Data.Monoid
import           ListApplicative
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

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
