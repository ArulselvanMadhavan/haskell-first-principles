{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Ex1 where

class TooMany a where
    tooMany :: a -> Bool

instance TooMany Int where
    tooMany n = n > 42

newtype Goats =
    Goats Int deriving (Show, Eq)

instance TooMany Goats where
    tooMany (Goats g) =
        tooMany g

instance TooMany (Int, String) where
    tooMany (i, s) = tooMany i

instance TooMany (Int, Int) where
    tooMany (i1, i2) = tooMany (i1 + i2)

instance (Num a, TooMany a) => TooMany (a, a) where
    tooMany (n, i) = tooMany n && tooMany i


-- instance TooMany Goats where
--     tooMany (Goats n) = n > 43
