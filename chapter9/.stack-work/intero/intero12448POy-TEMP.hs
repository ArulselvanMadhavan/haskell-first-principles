module Ex2 where


word :: Char -> String -> String
word sep txt =
    takeWhile (/= sep) . dropWhile (== sep) $ txt

dropWord :: Char -> String -> String
dropWord sep txt =
    dropWhile (== sep) . dropWhile (/= sep) $ txt

myWords :: Char -> String -> [String]
myWords sep txt =
    case txt of
      [] -> []
      _  -> (word sep txt) : (myWords sep . dropWord sep $ txt)
