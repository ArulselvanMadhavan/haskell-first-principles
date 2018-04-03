import qualified ConstantInstanceTests as CI
import qualified IdentityInstanceTests as IT
import qualified MaybeInstanceTests    as MI
import qualified SkiFreeTests          as SI

main :: IO ()
main = do
    IT.runTests
    CI.runTests
    MI.runTests
    -- SI.runTests
