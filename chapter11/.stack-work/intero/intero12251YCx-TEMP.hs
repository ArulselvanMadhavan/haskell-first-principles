module Ex4 where
import           Data.Char
import           Data.List


indexOf :: (Eq a) => a -> [a] -> Int
indexOf a =
    foldr (\x -> \y -> if (a == x) then 0 else (if y /= (-1) then y + 1 else y)) (-1)

isSubseqOf :: (Eq a) => [a] -> [a] -> Bool
isSubseqOf _ [] = False
isSubseqOf [] _ = True
isSubseqOf x y
    | head x == head y = isSubseqOf (tail x) (tail y)
    | otherwise = isSubseqOf x (tail y)

accumulateWords :: (String, [String]) -> Char -> (String, [String])
accumulateWords acc c
    | c == ' ' = ("", (reverse . fst $ acc) : snd acc)
    | otherwise = (c : fst acc, snd acc)

split :: String -> [String]
split str =
    (reverse . fst $ result) : (snd result)
    where result = foldl' accumulateWords ("", []) str


duplicateUpper :: String -> (String, String)
duplicateUpper str@(x: xs) =
    (str, toUpper x : xs)

capitalizeWords :: String -> [(String, String)]
capitalizeWords str =
    map duplicateUpper $ split str

capitalizeWord :: [Char] -> String
capitalizeWord (x : xs) =
    toUpper x : xs

capitalizeStart :: (Bool, String) -> Char -> (Bool, String)
capitalizeStart acc c =
    case c of
      '.' -> (True, c : snd acc)
      ' ' -> (fst acc, c : snd acc)
      _ -> if fst acc then (False, toUpper c : snd acc) else (False, c : snd acc)

capitalizeParagraph :: String -> String
capitalizeParagraph =
    reverse . snd . foldl' capitalizeStart (False, "")
