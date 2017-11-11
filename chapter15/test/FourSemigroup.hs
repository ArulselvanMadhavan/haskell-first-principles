module FourSemigroup where
import           Data.List.NonEmpty
import           Data.Semigroup
import           Test.QuickCheck

data Four a b c d =
    Four a b c d
    deriving (Eq, Show)

instance (Semigroup a, Semigroup b, Semigroup c, Semigroup d) => Semigroup (Four a b c d) where
    (Four a1 b1 c1 d1) <> (Four a2 b2 c2 d2) = Four (a1 <> a2) (b1 <> b2) (c1 <> c2) (d1 <> d2)

instance (Arbitrary a, Arbitrary b, Arbitrary c, Arbitrary d) => Arbitrary (Four a b c d) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        c <- arbitrary
        d <- arbitrary
        return $ Four a b c d

fourAssoc :: (Eq a, Eq b, Eq c, Eq d, Semigroup a, Semigroup b, Semigroup c, Semigroup d, Semigroup d)  => Four a b c d -> Four a b c d -> Four a b c d -> Bool
fourAssoc a b c =
    a <> (b <> c) == (a <> b) <> c

type FourStringInt = Four (NonEmpty String) (NonEmpty Int) (NonEmpty String) (NonEmpty Int)
type FourStringIntAssoc = FourStringInt -> FourStringInt -> FourStringInt -> Bool

runTests :: IO ()
runTests = do
    quickCheck (fourAssoc :: FourStringIntAssoc)


