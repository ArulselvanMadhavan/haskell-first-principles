{-# LANGUAGE InstanceSigs #-}
module Bifunctor where

class Bifunctor p where
  {-# MINIMAL bimap | first, second #-}
  bimap :: (a -> b) -> (c -> d) -> p a c -> p b d
  bimap f g = first f . second g
  first :: (a -> b) -> p a c -> p b c
  first f = bimap f id
  second :: (c -> d) -> p a c -> p a d
  second g = bimap id g


data Deux a b =
  Deux a
       b
  deriving (Eq, Show)

instance Bifunctor Deux where
  bimap f g (Deux a b) = Deux (f a) (g b)

data Const a b = Const a deriving (Eq, Show)

instance Bifunctor Const where
    bimap f g (Const a) = Const (f a)

data Drei a b c =
  Drei a
       b
       c
  deriving (Eq, Show)

instance Bifunctor (Drei a) where
  bimap f g (Drei a b c) = Drei a (f b) (g c)

data SuperDrei a b c =
  SuperDrei a
            b
  deriving (Eq, Show)

instance Bifunctor (SuperDrei a) where
  bimap f g (SuperDrei a b) = SuperDrei a (f b)

data SemiDrei a b c = SemiDrei a
    deriving (Eq, Show)

instance Bifunctor (SemiDrei a) where
    bimap f g (SemiDrei a) = SemiDrei a

data Quadriceps a b c d = Quadzzz a b c d deriving (Eq, Show)

instance Bifunctor (Quadriceps a b) where
  bimap f g (Quadzzz a b c d) = Quadzzz a b (f c) (g d)

data Either' a b
  = Left' a
  | Right' b
  deriving (Eq, Show)

instance Bifunctor Either' where
  bimap f g (Left' a)  = Left' (f a)
  bimap f g (Right' b) = Right' (g b)
