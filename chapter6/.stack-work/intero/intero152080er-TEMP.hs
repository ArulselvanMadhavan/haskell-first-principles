data TisAnInteger =
    TisAnInteger

instance Eq TisAnInteger where
    (==) TisAnInteger TisAnInteger = True

data TwoIntegers =
    Two Integer Integer

instance Eq TwoIntegers where
    (==) (Two a b) (Two c d) =
        (a == c) && (b == d)


data StringOrInt =
    TisAnInt Int
  | TisAString String

instance Eq StringOrInt where
    (==) (TisAnInt a) (TisAnInt b) =
        (a == b)
    (==) (TisAString a) (TisAString b) =
        (a == b)
    (==) _ _ = False

data Pair a =
    Pair a a

instance Eq a => Eq (Pair a) where
    (==) (Pair b c) (Pair d e) =
        (b == d) && (c == e)

data Tuple a b =
    Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
    (==) (Tuple a1 b1) (Tuple a2 b2) =
        (a1 == a2) && (b1 == b2)
