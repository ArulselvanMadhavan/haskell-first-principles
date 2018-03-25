module ListMonadTests where
import           ListMonad
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

test1 :: List' (String, Int, Int)
test1 = undefined

runTests :: IO ()
runTests = do
    quickBatch (monad test1)
