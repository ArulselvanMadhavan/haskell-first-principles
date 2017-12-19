{-# LANGUAGE ViewPatterns #-}

import           InstancesOfFunc
import           Test.QuickCheck
import           Test.QuickCheck.Function

type IntToInt = Fun Int Int

type IntFC = [Int] -> IntToInt -> IntToInt -> Bool

type IdentityCompose = Identity Int -> IntToInt -> IntToInt -> Bool

type PairCompose = Pair Int -> IntToInt -> IntToInt -> Bool

type TwoCompose = Two String Int -> IntToInt -> IntToInt -> Bool

type ThreeCompose = Three Bool String Int -> IntToInt -> IntToInt -> Bool

type ThreeCompose' = Three' String Int -> IntToInt -> IntToInt -> Bool

type FourCompose = Four String Int String Int -> IntToInt -> IntToInt -> Bool

type FourCompose' = Four' String Int -> IntToInt -> IntToInt -> Bool

functorIdentity :: (Functor f, Eq (f a)) => f a -> Bool
functorIdentity f = fmap id f == f

functorCompose :: (Functor f, Eq (f c)) => (a -> b) -> (b -> c) -> f a -> Bool
functorCompose f g x = (fmap g (fmap f x)) == fmap (g . f) x

functorCompose' :: (Functor f, Eq (f c)) => f a -> Fun a b -> Fun b c -> Bool
functorCompose' x (Fun _ f) (Fun _ g) =
  (fmap g (fmap f x)) == (fmap g . fmap f $ x)

main :: IO ()
main = do
  quickCheck (functorIdentity :: [Int] -> Bool)
  quickCheck (functorCompose (+ 1) (* 2) :: [Int] -> Bool)
  quickCheck (functorCompose' :: IntFC)
  quickCheck (functorIdentity :: (Identity Int) -> Bool)
  quickCheck (functorCompose' :: IdentityCompose)
  quickCheck (functorIdentity :: (Pair Int) -> Bool)
  quickCheck (functorCompose' :: PairCompose)
  quickCheck (functorIdentity :: (Two String Int) -> Bool)
  quickCheck (functorCompose' :: TwoCompose)
  quickCheck (functorIdentity :: (Three Bool String Int) -> Bool)
  quickCheck (functorCompose' :: ThreeCompose)
  quickCheck (functorIdentity :: (Three' String Int) -> Bool)
  quickCheck (functorCompose' :: ThreeCompose')
  quickCheck (functorIdentity :: (Four String Int String Int) -> Bool)
  quickCheck (functorCompose' :: FourCompose)
  quickCheck (functorIdentity :: (Four' String Int) -> Bool)
  quickCheck (functorCompose' :: FourCompose')
