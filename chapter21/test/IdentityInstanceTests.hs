module IdentityInstanceTests where
import           IdentityInstance         (Identity)
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

type TI = Identity


runTests :: IO()
runTests = do
    let trigger :: TI (Int, Int, [Int])
        trigger = undefined
        trigger2 :: TI (String, Int, [Int])
        trigger2 = undefined
    quickBatch (traversable trigger)
    quickBatch (traversable trigger2)
