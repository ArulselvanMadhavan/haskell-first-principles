module Sum where

data Sum a b =
    First a
    | Second b

instance Functor (Sum a) where
    fmap f (Second b) = Second (f b)
    fmap f (First a)  = First a
