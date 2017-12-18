module Functors1 where

data FixMePls
  = FixMe
  | Pls
  deriving (Eq, Show)

instance Functor FixMePls where
    fmap =
        error "this won't compile because FixMePls is not a higher kinded type"
