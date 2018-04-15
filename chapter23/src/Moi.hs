{-# LANGUAGE InstanceSigs #-}
module Moi where
import           Data.Monoid
import           Data.Tuple  (swap)

newtype Moi s a = Moi
  { runMoi :: s -> (a, s)
  }

flipAndModify :: (a -> b) -> (a, s) -> (b, s)
flipAndModify f t = swap . fmap f . swap $ t

funcHelper :: (a -> b) -> (s -> (a, s)) -> (s -> (b, s))
funcHelper f = fmap (flipAndModify f)

appHelper :: (Monoid s) => (a -> b, s) -> (a, s) -> (b, s)
appHelper abs as = (fst $ flipAndModify (fst abs) as, (snd abs) <> (snd as))

instance Functor (Moi s) where
  fmap :: (a -> b) -> Moi s a -> Moi s b
  fmap f (Moi g) = Moi $ funcHelper f g

instance Applicative (Moi s) where
  pure :: a -> Moi s a
  pure a = Moi (\s -> (a, s))
  (<*>) :: Moi s (a -> b) -> Moi s a -> Moi s b
  (<*>) (Moi g) (Moi h) = Moi $ do
      (fa, fs) <- g
      let (sa, ss) = h fs
      return $ (fa sa, ss)

instance Monad (Moi s) where
  return :: a -> Moi s a
  return = pure
  (>>=) :: Moi s a -> (a -> Moi s b) -> Moi s b
  (>>=) (Moi s) g =
    Moi $ do
      (a, sa) <- s
      let Moi sb = g a
      return $ sb sa
