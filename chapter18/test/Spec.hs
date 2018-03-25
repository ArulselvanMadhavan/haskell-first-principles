module Main where
import qualified ChapterExercise1Tests
import qualified IdentityMonadTests
import qualified ListMonadTests

main :: IO ()
main = do
    ChapterExercise1Tests.runTests
    IdentityMonadTests.runTests
    ListMonadTests.runTests
