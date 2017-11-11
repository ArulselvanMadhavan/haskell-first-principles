{-# LANGUAGE DeriveGeneric #-}
module Combine where

import qualified Data.Semigroup  as S
import           GHC.Generics
import           Test.QuickCheck

newtype Sum a =
    Sum {getSum :: a}
    deriving (Eq, Show)

instance Num a => Num (Sum a) where
    (+) (Sum x) (Sum y) = Sum (x + y)
    (-) (Sum x) (Sum y) = Sum (x - y)
    (*) (Sum x) (Sum y) = Sum (x * y)
    abs (Sum x) = Sum (abs x)
    signum (Sum x) = Sum (signum x)
    fromInteger x = Sum (fromInteger x)

instance (Arbitrary a) => Arbitrary (Sum a) where
    arbitrary = do
        a <- arbitrary
        return $ Sum a

newtype Combine a b =
    Combine {unCombine :: (a -> b)}

-- instance (Eq a, Eq b) => Eq (Combine a b) where
--     (==) (Combine x) (Combine y) =


-- instance (Show a, Show b) => Show (Combine a b) where
--     show (Combine x) =
--         show x

instance (Num b) => S.Semigroup (Combine a b) where
    (Combine f) <> (Combine g) =
        Combine (\a -> (f a) + (g a))

-- instance (Arbitrary a, Arbitrary b) => Arbitrary (Combine a b) where
--     arbitrary = do
--         a <- arbitrary
--         return $ Combine a

combineAssoc :: (Eq b, Num b) => Combine a b -> Combine a b -> Combine a b -> a -> Bool
combineAssoc f g h val =
    let x = unCombine (f S.<> (g S.<> h)) $ val
        y = unCombine ((f S.<> g) S.<> h) $ val
    in  x == y

testFunc1 :: Int -> Sum Int
testFunc1 x =
    Sum (x + 1)

testFunc2 :: Int -> Sum Int
testFunc2 x =
    Sum (x - 1)

testFunc3 :: Int -> Sum Int
testFunc3 x =
    Sum (x + 2)

-- funcGen :: Gen (Sum Int)
-- funcGen =
--     coarbitrary 0 arbitrary

runTests :: IO ()
runTests = do
    quickCheck ((combineAssoc (Combine testFunc1) (Combine testFunc2) (Combine testFunc3)) :: Int -> Bool)
