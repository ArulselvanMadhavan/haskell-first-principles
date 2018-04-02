module MaybeInstanceTests where

import           MaybeInstance
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes


runTests :: IO ()
runTests = do
    let trigger :: Optional (String, Int, [String])
        trigger = undefined
        trigger1 :: Optional (Int, String, [Int])
        trigger1 = undefined
    quickBatch (traversable trigger)
    quickBatch (traversable trigger1)
