module MaybeMonoidTest where
import           Control.Monad
import           Data.Monoid
import           MonoidTestUtils
import           Test.QuickCheck

newtype First' a =
    First' { getFirst' :: Maybe a }
    deriving (Eq, Show)

instance Monoid (First' a) where
    mempty = First' (Nothing)
    mappend (First' (Just x)) _ = First' (Just x)
    mappend (First' Nothing) y  = y

instance Arbitrary a => Arbitrary (First' a) where
    arbitrary = firstGen

firstGen :: Arbitrary a => Gen (First' a)
firstGen = do
    a <- arbitrary
    frequency [ (1, return $ First' Nothing)
              , (3, return $ First' (Just a)) ]

firstMappend :: First' a -> First' a -> First' a
firstMappend =
    mappend

type FirstMappend =
    First' String
 -> First' String
 -> First' String
 -> Bool

type FstId = First' String -> Bool

runTests :: IO()
runTests = do
    quickCheck (monoidAssoc :: FirstMappend)
    quickCheck (monoidLeftIdentity :: FstId)
    quickCheck (monoidRightIdentity :: FstId)
