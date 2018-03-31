module Ex2 where
import           Data.Monoid

data Constant a b =
    Constant b
    deriving (Eq, Show)

data Two a b =
  Two a
      b
  deriving (Eq, Show)

data Three a b c =
  Three a
        b
        c
  deriving (Eq, Show)

data Three' a b =
  Three' a
         b
         b
  deriving (Eq)

data Four' a b =
  Four' a
        b
        b
        b
  deriving (Eq, Show)

instance Foldable (Constant a) where
  foldr f b (Constant b1) = f b1 b
  foldMap f (Constant b) = f b

instance Foldable (Three a b) where
    foldr f d (Three a b c) = f c d
    foldMap f (Three a b c) = f c

instance (Show a, Show b, Monoid b) => Show (Three' a b) where
    show (Three' a b1 b2) = (show a) ++ (show b1)

instance Foldable (Three' a) where
    foldMap f (Three' a b1 b2) = (<>) (f b1) (f b2)
    foldr f c (Three' a b1 b2) = f b2 c --We can't use monoid here
