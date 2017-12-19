{-# LANGUAGE ViewPatterns #-}

import           Test.QuickCheck
import           Test.QuickCheck.Function

type IntToInt = Fun Int Int
type IntFC = [Int] -> IntToInt -> IntToInt -> Bool

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
