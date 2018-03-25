module ChapterExercise1Tests where
import           ChapterExercise1
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

test1 :: Nope (Int, String, Int)
test1 = undefined

eitherTest :: AnotherEither String (Int, String, Int)
eitherTest = undefined

runTests :: IO ()
runTests = do
    quickBatch (monad test1)
    quickBatch (monad eitherTest)
