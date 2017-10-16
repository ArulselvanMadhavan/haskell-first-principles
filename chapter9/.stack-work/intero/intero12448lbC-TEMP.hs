module Ex3 where
import           Data.Char

filterUpper :: String -> String
filterUpper s =
    filter isUpper s

capitalize :: String -> String
capitalize s =
    case s of
      []    -> []
      x: xs -> toUpper x : capitalize xs

capitalizedHead :: String -> Char
capitalizedHead =
    toUpper . head
