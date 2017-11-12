module TrivialSemigroup where

import qualified Data.Monoid     as M
import           Data.Semigroup
import           MonoidTestUtils
import           Test.QuickCheck

data Trivial = Trivial deriving (Eq, Show)

instance Semigroup Trivial where
    _ <> _ = Trivial

instance Monoid Trivial where
    mempty = Trivial
    mappend = (<>)

instance Arbitrary Trivial where
    arbitrary = return Trivial

semigroupAssoc :: (Eq m, Semigroup m) => m -> m -> m -> Bool
semigroupAssoc a b c =
    a <> (b <> c) == (a <> b) <> c

type TrivAssoc =
    Trivial -> Trivial -> Trivial -> Bool

runTests :: IO ()
runTests = do
    let mli = monoidLeftIdentity
        mri = monoidRightIdentity
    quickCheck (semigroupAssoc :: TrivAssoc)
    quickCheck (mli :: Trivial -> Bool)
    quickCheck (mri :: Trivial -> Bool)
