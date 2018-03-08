module ListApplicativeTests where

import           ListApplicative
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

listD :: List (String, String, Int)
listD = Cons ("A", "b", 3) Nil


runTests :: IO ()
runTests = quickBatch (applicative listD)
