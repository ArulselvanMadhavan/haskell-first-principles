module Ex4 where
import           Data.Maybe

data Nat =
    Zero
  | Succ Nat
  deriving (Eq, Show)

natToInteger :: Nat -> Integer
natToInteger Zero     = 0
natToInteger (Succ x) = (1 + (natToInteger x))

integerToNat :: Integer -> Maybe Nat
integerToNat x
    | x < 0 = Nothing
    | x == 0 = Just Zero
    | otherwise = Just (Succ (fromJust . integerToNat $ (x - 1)))
