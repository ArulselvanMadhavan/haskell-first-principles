module OrSemigroup where

import           Data.Semigroup
import           Test.QuickCheck

data Or a b =
    Fst a
  | Snd b
  deriving (Eq, Show)

instance Semigroup (Or a b) where
    a <> b = case (a, b) of
               (_ , Snd y)    -> Snd y
               (Snd x, Fst y) -> Snd x
               (_ , Fst y)    -> Fst y


instance (Arbitrary a, Arbitrary b) => Arbitrary (Or a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        frequency [ (1, return $ Fst a)
                  , (1, return $ Snd b)
                  ]

orAssoc :: (Eq a, Eq b) => Or a b -> Or a b -> Or a b -> Bool
orAssoc a b c =
    (a <> (b <> c)) == ((a <> b) <> c)

runTests :: IO ()
runTests = do
    quickCheck (orAssoc :: Or String Int -> Or String Int -> Or String Int -> Bool)
