{-# LANGUAGE FlexibleContexts #-}
module SkiFree where

import           Test.QuickCheck
import           Test.QuickCheck.Checkers

-- n has to be a higher kinded type
data S n a =
  S (n a)
    a
  deriving (Eq, Show)

instance (Functor n, Arbitrary (n a), Arbitrary a) => Arbitrary (S n a) where
  arbitrary = do
    S <$> arbitrary <*> arbitrary

instance (Applicative n, Testable (n Property), EqProp a) =>
         EqProp (S n a) where
  (S x y) =-= (S p q) = (property $ (=-=) <$> x <*> p) .&. (y =-= q)

instance Functor n => Functor (S n) where
  fmap f (S n a) = S (fmap f n) (f a)

instance Applicative n => Applicative (S n) where
    pure a = S (pure a) a
    (<*>) (S f ff) (S n a) = S (f <*> n) (ff a)

instance Foldable n => Foldable (S n) where
  foldMap f (S n a) = (foldMap f n) `mappend` f a
  foldr f z (S n a) = f a z

instance Traversable n => Traversable (S n) where
    traverse f (S n a) = let res1 = sequenceA $ fmap f n --Traversable n (Applicative b)
                         in
                           S <$> res1 <*> f a
