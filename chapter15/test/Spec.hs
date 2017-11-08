import           Data.Monoid
import           Test.QuickCheck

monoidAssoc :: (Eq m, Monoid m) => m -> m -> m -> Bool
monoidAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

monoidLeftIdentity :: (Eq m, Monoid m) => m -> Bool
monoidLeftIdentity a =
    (mempty <> a) == a

monoidRightIdentity :: (Eq m, Monoid m) => m -> Bool
monoidRightIdentity a =
    (a <> mempty) == a

testStringMonoidAssoc :: IO ()
testStringMonoidAssoc =
    quickCheck (monoidAssoc :: String -> String -> String -> Bool)

testStringLeftIdentity :: IO ()
testStringLeftIdentity =
    quickCheck (monoidLeftIdentity :: String -> Bool)

main :: IO ()
main = do
    testStringMonoidAssoc
    testStringLeftIdentity
