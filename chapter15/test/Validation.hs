module Validation where

import           Data.Semigroup
import qualified Test.QuickCheck as T

data Validation a b =
    Failure a
  | Success b
  deriving (Eq, Show)

instance Semigroup a => Semigroup (Validation a b) where
    (<>) _ (Success b)             = Success b
    (<>) (Success b) _             = Success b
    (<>) (Failure a1) (Failure a2) = Failure (a1 <> a2)

instance (T.Arbitrary a, T.Arbitrary b) => T.Arbitrary (Validation a b) where
    arbitrary = do
        a <- T.arbitrary
        b <- T.arbitrary
        T.frequency [ (1, return $ Success a)
                    , (2, return $ Failure b)
                    ]

validationAssoc :: (Eq a, Eq b, Semigroup a) => Validation a b -> Validation a b -> Validation a b -> Bool
validationAssoc a b c =
    a <> (b <> c) == (a <> b) <> c

runTests :: IO ()
runTests = do
    T.quickCheck (validationAssoc :: Validation String Int -> Validation String Int -> Validation String Int -> Bool)

sometests = do
    let failure :: String -> Validation String Int
        failure = Failure
        success :: Int -> Validation String Int
        success = Success
    print $ success 1 <> failure "blah"
    print $ failure "woot" <> failure "blah"
    print $ success 1 <> success 2
    print $ failure "woot" <> success 2
