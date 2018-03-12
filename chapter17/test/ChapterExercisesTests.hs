module ChapterExercisesTests where

import           ChapterExercises
import           Data.Monoid
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes
pairTest1 :: Pair (String, String, Int)
pairTest1 = undefined

twoTest1 :: Two String (Int, String, Int)
twoTest1 = undefined

threeTest :: Three (Sum Int) String (Int, Int, String)
threeTest = undefined

threeTest' :: Three' (Sum Int) (String, Int, String)
threeTest' = undefined

runTests :: IO ()
runTests = do
    quickBatch (applicative pairTest1)
    quickBatch (applicative twoTest1)
    quickBatch (applicative threeTest)
    quickBatch (applicative threeTest')
