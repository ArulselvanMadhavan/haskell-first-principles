module ConstantInstanceTests where

import           ConstantInstance
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

runTests :: IO ()
runTests = do
  let trigger1 :: Constant Int (String, Int, [Int])
      trigger1 = undefined
      trigger2 :: Constant String (Int, String, [String])
      trigger2 = undefined
  quickBatch (traversable trigger1)
  quickBatch (traversable trigger2)
