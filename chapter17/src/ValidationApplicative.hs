module ValidationApplicative where

import qualified Test.QuickCheck          as QC
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

data Validation e a
  = Failure e
  | Success a
  deriving (Eq, Show)

instance Functor (Validation e) where
    fmap f (Failure xs) = Failure xs
    fmap f (Success a)  = Success (f a)

instance Monoid e => Applicative (Validation e) where
    pure a = Success a
    (<*>) (Failure xs) (Failure ys) = Failure (xs `mappend` ys)
    (<*>) (Failure xs) _            = Failure xs
    (<*>) _ (Failure ys)            = Failure ys
    (<*>) (Success f) (Success y)   = Success (f y)

instance (Monoid e, QC.Arbitrary e, QC.Arbitrary a) => QC.Arbitrary (Validation e a) where
    arbitrary = do
        e <- QC.arbitrary
        a <- QC.arbitrary
        QC.elements [Failure e, Success a]

instance (Eq e, Eq a) => EqProp (Validation e a) where
    (=-=) = eq
