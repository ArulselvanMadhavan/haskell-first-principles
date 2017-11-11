module Main where
import qualified Bull
import qualified MaybeMonoidTest
import qualified MonoidTestUtils
import qualified SemigroupUtils
import qualified TrivialSemigroup

main :: IO ()
main = do
    MonoidTestUtils.runTests
    MaybeMonoidTest.runTests
    Bull.runTests
    SemigroupUtils.runTests
    TrivialSemigroup.runTests
