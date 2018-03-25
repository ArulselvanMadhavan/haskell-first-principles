module ChapterExercise1 where
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

data Nope a =
    NopeDotJpg
    deriving (Eq, Show)

instance Functor Nope where
    fmap f _ = NopeDotJpg

instance Applicative Nope where
  pure _ = NopeDotJpg
  (<*>) _ _ = NopeDotJpg

instance Monad Nope where
    return = pure
    (>>=) _ _ = NopeDotJpg

instance Arbitrary a => Arbitrary (Nope a) where
    arbitrary = do
        return NopeDotJpg

instance Eq a => EqProp (Nope a) where
    (=-=) = eq

data AnotherEither b a
  = Left' a
  | Right' b
  deriving (Eq, Show)

instance Functor (AnotherEither b) where
    fmap f (Left' a)  = Left' (f a)
    fmap f (Right' b) = Right' b

instance (Monoid b) => Applicative (AnotherEither b) where
    pure a = Left' a
    (<*>) (Left' f) (Left' a)     = Left' (f a)
    (<*>) (Right' b1) (Right' b2) = Right' (b1 `mappend` b2)
    (<*>) (Right' b) (Left' a)    = Right' b
    (<*>) (Left' a) (Right' b)    = Right' b

instance (Monoid b) => Monad (AnotherEither b) where
    return = pure
    (>>=) (Left' a) f  = f a
    (>>=) (Right' b) f = (Right' b)

instance (Eq a, Eq b) => EqProp (AnotherEither b a) where
  (=-=) = eq

instance (Arbitrary a, Arbitrary b) => Arbitrary (AnotherEither b a) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    elements [Left' a, Right' b]
