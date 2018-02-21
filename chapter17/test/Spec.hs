module Main where
import qualified BadMonoid

main :: IO ()
main = do
    BadMonoid.runTests
