module ValidationApplicativeTests where

import           Data.Monoid
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes
import           ValidationApplicative

success1 :: Validation String (String, String, Int)
success1 = Success ("a", "b", 1)

failure1 :: Validation (Sum Int) (Int, String, String)
failure1 = Failure (Sum 1)

failure2 :: Validation [String] (Int, Int, String)
failure2 = Failure ["Test"]

runTests :: IO ()
runTests = do
    quickBatch (applicative success1)
    quickBatch (applicative failure1)
    quickBatch (applicative failure2)
