module SkiFreeTests where

import           SkiFree
import           Test.QuickCheck
import           Test.QuickCheck.Checkers
import           Test.QuickCheck.Classes

runTests :: IO [S [] Int]
runTests = sample' (arbitrary :: Gen (S [] Int))
    -- let trigger :: S [] (String, String, [String])
    --     trigger = undefined
    -- quickBatch (traversable trigger) --For some reason fmap properties seem to fail
