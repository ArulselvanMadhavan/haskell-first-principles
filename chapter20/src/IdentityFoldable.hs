module IdentityFoldable where

data Identity a =
  Identity a
  deriving (Eq, Show)


instance Foldable Identity where
    foldr f z (Identity x) = f x z
    foldl f z (Identity x) = f z x
    foldMap f (Identity x) = f x
