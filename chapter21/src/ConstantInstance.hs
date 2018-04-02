module ConstantInstance where
import           Test.QuickCheck
import           Test.QuickCheck.Checkers

newtype Constant a b = Constant
  { getConstant :: a
  } deriving (Eq, Show)

instance Functor (Constant a) where
  fmap f (Constant a) = Constant a

instance (Monoid a) => Applicative (Constant a) where
    pure a = Constant mempty
    Constant f <*> Constant a = Constant a

instance Foldable (Constant a) where
    foldMap f (Constant a) = mempty
    foldr f z (Constant a) = z

instance Traversable (Constant a) where
    traverse f (Constant a) = pure (Constant a)

instance Arbitrary a => Arbitrary (Constant a b) where
    arbitrary = do
        a <- arbitrary
        return $ Constant a

instance (Eq a) => EqProp (Constant a b) where
  (=-=) = eq
