module Phone where

import Data.Char

data Key = One | Two | Three | Four | Five | Six | Seven | Eight | Nine | Star | Zero | Pound deriving (Show, Eq, Enum)

data KeyPress = Key Int

digitToKey :: Char -> KeyPress

charToKey :: Char -> KeyPress
charToKey c
    | c

reverseTaps :: Char -> [KeyPress]
reverseTaps =
    


