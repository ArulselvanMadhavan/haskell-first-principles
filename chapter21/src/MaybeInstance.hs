module MaybeInstance where

import           Test.QuickCheck
import           Test.QuickCheck.Checkers

data Optional a
  = Nada
  | Yep a
  deriving (Eq, Show)


instance Functor Optional where
  fmap f Nada    = Nada
  fmap f (Yep a) = Yep (f a)

instance Applicative Optional where
  pure a = Yep a
  (<*>) (Yep f) (Yep a) = Yep $ f a
  (<*>) _ _             = Nada

instance Foldable Optional where
  foldMap f (Yep a) = f a
  foldMap f Nada    = mempty
  foldr f z (Yep a) = f a z
  foldr f z Nada    = z

instance Traversable Optional where
  traverse f (Yep a) = Yep <$> f a
  traverse f Nada    = pure Nada

instance Arbitrary a => Arbitrary (Optional a) where
  arbitrary = do
    a <- arbitrary
    elements [Nada, Yep a]

instance (Eq a) => EqProp (Optional a) where
    (=-=) = eq
