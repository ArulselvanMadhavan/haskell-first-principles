module Main where
import qualified BoolConj
import qualified Bull
import qualified FourSemigroup
import qualified IdentitySemigroup
import qualified MaybeMonoidTest
import qualified MonoidTestUtils
import qualified OrSemigroup
import qualified SemigroupUtils
import qualified TrivialSemigroup
import qualified TwoSemigroup

main :: IO ()
main = do
    MonoidTestUtils.runTests
    MaybeMonoidTest.runTests
    Bull.runTests
    SemigroupUtils.runTests
    TrivialSemigroup.runTests
    IdentitySemigroup.runTests
    TwoSemigroup.runTests
    FourSemigroup.runTests
    BoolConj.runTests
    OrSemigroup.runTests
