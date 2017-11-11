module SemigroupUtils where
import qualified Data.List.NonEmpty as N
import           Data.Semigroup
import           Test.QuickCheck

semiGroupAssoc :: (Eq s, Semigroup s) => s -> s -> s -> Bool
semiGroupAssoc a b c =
    (a <> b) <> c == a <> (b <> c)

testStringNonEmptyList :: IO()
testStringNonEmptyList =
    quickCheck (semiGroupAssoc :: N.NonEmpty Int -> N.NonEmpty Int -> N.NonEmpty Int -> Bool)

runTests :: IO()
runTests = do
    testStringNonEmptyList
