module Main where
import qualified ChapterExercise1Tests
import qualified IdentityMonadTests

main :: IO ()
main = do
    ChapterExercise1Tests.runTests
    IdentityMonadTests.runTests
