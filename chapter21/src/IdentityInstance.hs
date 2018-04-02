module IdentityInstance where
import           Test.QuickCheck
import           Test.QuickCheck.Checkers

newtype Identity a =
    Identity a
    deriving (Eq, Show, Ord)

instance Functor Identity where
    fmap f (Identity a) = Identity $ f a

instance Applicative Identity where
    pure a = Identity a
    Identity f <*> Identity a = Identity $ f a

instance Foldable Identity where
    foldMap f (Identity a) = f a
    foldr f z (Identity a) = f a z

instance Traversable Identity where
    traverse f (Identity a) = Identity <$> f a

instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = do
        a <- arbitrary
        return $ Identity a

instance (Eq a) => EqProp (Identity a) where
    (=-=) = eq
