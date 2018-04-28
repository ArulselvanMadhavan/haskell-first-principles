{-# LANGUAGE InstanceSigs #-}
module IdentityT where

newtype Identity a = Identity
  { runIdentity :: a
  } deriving (Eq, Show)

newtype IdentityT f a = IdentityT
  { runIdentityT :: f a
  } deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance (Functor f) => Functor (IdentityT f) where
  fmap f (IdentityT fa) = IdentityT (fmap f fa)

instance Applicative Identity where
  pure = Identity
  (<*>) (Identity f) (Identity a) = Identity (f a)

instance (Applicative f) => Applicative (IdentityT f) where
  pure a = IdentityT (pure a)
  (<*>) (IdentityT gb) (IdentityT fa) = IdentityT (gb <*> fa)

instance Monad Identity where
  return = pure
  (Identity a) >>= f = f a

instance (Monad f) => Monad (IdentityT f) where
  return = pure
  (>>=) :: IdentityT f a -> (a -> IdentityT f b) -> IdentityT f b
  (IdentityT fa) >>= f = IdentityT $ fa >>= (runIdentityT . f)