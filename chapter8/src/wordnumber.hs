module WordNumber where

import           Data.List (intersperse)

digitToWord :: Int -> String
digitToWord n =
    case n of
      0 -> "Zero"
      1 -> "One"
      2 -> "Two"
      3 -> "Three"
      4 -> "Four"
      5 -> "Five"
      6 -> "Six"
      7 -> "Seven"
      8 -> "Eight"
      9 -> "Nine"

digits :: Int -> [Int]
digits n = go n []
    where go ds l
              | (ds <= 0) = l
              | otherwise = go (fst x) (flip (:) l . snd $ x)
                            where x = divMod ds 10

wordNumber :: Int -> String
wordNumber n =
    concat . intersperse "-" . map digitToWord . digits $ n
