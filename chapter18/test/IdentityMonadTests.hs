module IdentityMonadTests where
import           IdentityMonad
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

test1 :: Identity (String,Int,String)
test1 = undefined

runTests :: IO ()
runTests = do
    quickBatch (monad test1)
