module Ex2 where

import           Data.List
import           Ex1       (split, splitWord)

isVowel :: Char -> Bool
isVowel =
    flip elem ['a', 'e', 'i', 'o', 'u']

startsWithVowel :: String -> Bool
startsWithVowel =
    isVowel . head

isThe :: String -> Bool
isThe "the" = True
isThe _     = False

countThe :: [String] -> Integer
countThe xs =
    case xs of
      x : [] -> 0
      x : y : ys -> if (isThe x && startsWithVowel y) then countThe (y:ys) + 1 else countThe (y:ys)

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel =
    countThe . (Ex1.split ' ')

countVowels :: String -> Integer
countVowels =
    foldr (\x -> \acc -> if isVowel x then acc + 1 else acc ) 0


