module Ex3 where
import           Ex2 (isVowel)

newtype Word' =
    Word' String deriving (Eq, Show)

vowelsCount :: String -> Int
vowelsCount =
    foldr (\x -> \acc -> if isVowel x then acc + 1 else acc) 0

data InvalidWord =
    MoreVowels deriving (Show, Eq)

validateWord :: String -> Either InvalidWord Word'
validateWord xs =
    if (numOfVowels > ((length xs) - numOfVowels)) then Left MoreVowels else Right (Word' xs)
    where numOfVowels = vowelsCount xs

mkWord :: String -> Maybe Word'
mkWord xs =
    case validateWord xs of
      Left _  -> Nothing
      Right w -> Just w
