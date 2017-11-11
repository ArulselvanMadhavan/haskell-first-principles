module IdentitySemigroup where

import           Data.Semigroup
import           Test.QuickCheck

newtype Identity a = Identity a deriving (Eq, Show)

instance Semigroup a => Semigroup (Identity a) where
    (Identity x) <> (Identity y) = Identity (x <> y)

instance Arbitrary a => Arbitrary (Identity a) where
    arbitrary = identityGen

identityGen :: Arbitrary a => Gen (Identity a)
identityGen = do
    a <- arbitrary
    return $ Identity a

identityAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
identityAssoc a b c =
    a <> (b <> c) == (a <> b) <> c

type IdentityAssoc =
    Identity String -> Identity String -> Identity String -> Bool

runTests :: IO ()
runTests = do
    quickCheck (identityAssoc :: IdentityAssoc)
