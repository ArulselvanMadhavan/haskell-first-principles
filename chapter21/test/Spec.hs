import qualified ConstantInstanceTests as CI
import qualified IdentityInstanceTests as IT

main :: IO ()
main = do
    IT.runTests
    CI.runTests
