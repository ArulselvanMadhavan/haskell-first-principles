module TwoSemigroup where
import qualified Data.List.NonEmpty as N
import           Data.Semigroup
import           Test.QuickCheck

data Two a b =
    Two a b
    deriving (Eq, Show)

instance (Semigroup a, Semigroup b) => Semigroup (Two a b) where
    (Two x y) <> (Two m n) = Two (x <> m) (y <> n)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
    arbitrary = twoGen

twoGen :: (Arbitrary a, Arbitrary b) => Gen (Two a b)
twoGen = do
    a <- arbitrary
    b <- arbitrary
    return $ Two a b

twoAssoc :: (Eq a, Eq b, Semigroup a, Semigroup b) => Two a b -> Two a b -> Two a b -> Bool
twoAssoc a b c =
    a <> (b <> c) == (a <> b) <> c

type TwoStringInt = Two String (N.NonEmpty Int)

type TwoAssocStringInt = TwoStringInt -> TwoStringInt -> TwoStringInt -> Bool

runTests :: IO ()
runTests = do
    quickCheck (twoAssoc :: TwoAssocStringInt)
