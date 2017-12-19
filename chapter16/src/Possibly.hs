module Possibly where

data Possibly a
  = LolNope
  | Yeppers a
  deriving (Eq, Show)

instance Functor Possibly where
    fmap f (Yeppers a) = Yeppers (f a)
    fmap _ LolNope     = LolNope


