{-# LANGUAGE InstanceSigs #-}

module StateT where

import           Control.Applicative
import           Data.Tuple          (swap)

                 -- Stricter version
newtype StateT s m a = StateT
  { runStateT :: s -> m (a, s)
  }

instance (Functor m) => Functor (StateT s m) where
  fmap :: (a -> b) -> StateT s m a -> StateT s m b
  fmap f (StateT sma) = StateT $ (fmap . fmap) (swap . (fmap f) . swap) sma

-- Why do we need a Monad m?
instance (Monad m) => Applicative (StateT s m) where
  pure a = StateT (\s -> pure (a, s))
  (<*>) :: StateT s m (a -> b) -> StateT s m a -> StateT s m b
  (StateT smab) <*> (StateT sma) =
    StateT $ \s -> do
      (f, fs) <- smab s
      (a, ss) <- sma fs
      return (f a, ss)

instance (Monad m) => Monad (StateT s m) where
  return = pure
  (StateT sma) >>= f =
    StateT $ \s -> do
      (a, ss) <- sma s
      (runStateT . f $ a) ss
