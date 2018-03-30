module Optional where

data Optional a
  = Nada
  | Yep a
  deriving (Eq, Show)

instance Foldable Optional where
    foldr _ z Nada    = z
    foldr f z (Yep a) = f a z

    foldl _ z Nada    = z
    foldl f z (Yep a) = f z a

    foldMap _ Nada    = mempty
    foldMap f (Yep a) = f a
