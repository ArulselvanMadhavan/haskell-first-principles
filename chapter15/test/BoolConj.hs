module BoolConj where

import           Data.Semigroup
import           Test.QuickCheck

newtype BoolConj = BoolConj Bool deriving (Eq, Show)

instance Semigroup BoolConj where
    BoolConj True <> BoolConj True = BoolConj True
    _ <> _ = BoolConj False

instance Arbitrary BoolConj where
    arbitrary = frequency [ (1, return $ BoolConj True)
                          , (1, return $ BoolConj False)
                          ]
instance Monoid BoolConj where
    mempty = BoolConj True
    mappend = (<>)

boolConjAssoc :: BoolConj -> BoolConj -> BoolConj -> Bool
boolConjAssoc a b c =
    a <> (b <> c) == (a <> b) <> c

runTests :: IO ()
runTests = do
    quickCheck boolConjAssoc
