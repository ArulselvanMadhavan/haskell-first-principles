module ListMonad where

import           Test.QuickCheck
import           Test.QuickCheck.Checkers

data List' a
  = Nil
  | Cons a
         (List' a)
  deriving (Eq, Show)

concat' :: List' a -> List' a -> List' a
concat' Nil ys         = ys
concat' xs Nil         = xs
concat' (Cons x xs) ys = Cons x (concat' xs ys)

instance Functor List' where
    fmap f Nil         = Nil
    fmap f (Cons x xs) = Cons (f x) (fmap f xs)

instance Applicative List' where
    pure a = Cons a Nil
    (<*>) (Cons f fs) xs = concat' (fmap f xs) ((<*>) fs xs)

instance Monad List' where
    return = pure
    (>>=) Nil f         = Nil
    (>>=) (Cons x xs) f = concat' (f x) ((>>=) xs f)

instance Arbitrary a => Arbitrary (List' a) where
    arbitrary = sized arbitraryList

arbitraryList :: Arbitrary a => Int -> Gen (List' a)
arbitraryList m
    | m == 0 = return Nil
    | m < 6 = Cons <$> arbitrary <*> (arbitraryList (m - 1))
    | otherwise = Cons <$> arbitrary <*> (arbitraryList 6)

instance Eq a => EqProp (List' a) where
    (=-=) = eq

