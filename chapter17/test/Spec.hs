module Main where
import qualified BadMonoid
import qualified ValidationApplicativeTests

main :: IO ()
main = do
    BadMonoid.runTests
    ValidationApplicativeTests.runTests
