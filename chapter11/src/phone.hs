{-# LANGUAGE Strict #-}
{-# OPTIONS_GHC -fwarn-incomplete-patterns #-}
module Phone where
import           Data.Char
import           Data.List
import qualified Data.Map.Strict as Map
import           Data.Maybe
import           Ex4


data Key = One | Two | Three | Four | Five | Six | Seven | Eight | Nine | Star | Zero | Pound deriving (Eq, Enum, Show, Ord)

data KeyPress = Key Int

data Phone =
    Phone [Key]
    deriving (Show)

type Presses = Int

keyToChars :: Key -> [Char]
keyToChars k =
    case k of
    Two   -> ['a', 'b', 'c', '2']
    Three -> ['d', 'e', 'f', '3']
    Four  -> ['g', 'h', 'i', '4']
    Five  -> ['j', 'k', 'l', '5']
    Six   -> ['m', 'n', 'o', '6']
    Seven -> ['p', 'q', 'r', 's', '7']
    Eight -> ['t', 'u', 'v', '8']
    Nine  -> ['w', 'x', 'y', 'z', '9']
    Zero  -> [' ', '0']
    One   -> ['1']
    Star  -> ['*']
    Pound -> ['#']

convo :: [String]
convo = ["Wanna play 20 questions",
         "Ya",
         "U 1st haha",
         "Lol ok. Have u ever tasted alcohol",
         "Lol ya",
         "Wow ur cool haha. Ur turn",
         "Ok. Do u think I am pretty Lol",
         "Lol ya",
         "Just making sure rofl ur turn"]

checkKeyAvail :: Key -> Maybe Int -> [(Key, Presses)] -> [(Key, Presses)]
checkKeyAvail k (Just idx) _ = (k, idx + 1 :: Presses) : []
checkKeyAvail _ _ acc        = acc

findValidKey :: Char -> Key -> [(Key, Presses)] -> [(Key, Presses)]
findValidKey c k acc =
    (flip $ checkKeyAvail k) acc . getKeyPress c $ k

getKeyPress :: Char -> Key -> Maybe Int
getKeyPress c =
    findIndex (== c) . keyToChars

getKeyPresses :: Char -> [Key] -> [(Key, Presses)]
getKeyPresses c =
    foldr (findValidKey c) []


reverseTaps :: Phone -> Char -> [(Key, Presses)]
reverseTaps (Phone keys) c
    | isUpper c = (Star, 1) : getKeyPresses (toLower c) keys
    | otherwise = getKeyPresses c keys

cellPhonesDead :: Phone -> String -> [(Key, Presses)]
cellPhonesDead p =
    concat . map (reverseTaps p)

fingerTaps :: [(Key, Presses)] -> Presses
fingerTaps =
    sum . map snd

convosToKeys :: [String] -> [[(Key, Presses)]]
convosToKeys =
    map (cellPhonesDead (Phone $ enumFrom One))

fingerTapsForConvos :: [Presses]
fingerTapsForConvos =
    map fingerTaps $ convosToKeys convo

popularKey :: [(Key, Presses)] -> Key
popularKey =
    fst . maximumBy (\(_, a) -> \(_, b) -> compare a b). Map.toList . Map.fromListWith (+)

popularCharForConvos :: [Key]
popularCharForConvos =
    map popularKey $ convosToKeys convo

keyPressesToChar :: (Key, Presses) -> Char
keyPressesToChar (k, p) =
   (flip (!!) $ (p - 1)) . keyToChars $ k

updateCharMap :: Char -> Map.Map Char Int -> Map.Map Char Int
updateCharMap c acc =
    case Map.member c acc of
      True  -> Map.update (\x -> Just (x + 1)) c acc
      False -> Map.insert c 1 acc

buildCharMap :: [Char] -> Map.Map Char Int
buildCharMap =
    foldr updateCharMap Map.empty

maximumWithIndex :: [(Char, Presses)] -> (Int, (Char, Presses))
maximumWithIndex xs =
     maximumBy (\x -> \y -> compare ((snd . snd) x) ((snd . snd) y)) $ zip [0..] xs

popularChar :: [Char]
popularChar =
     map (fst . snd . maximumWithIndex . Map.toList . buildCharMap . map keyPressesToChar) $ convosToKeys convo

wordCount :: [String] -> Map.Map String Int
wordCount sen =
    Map.fromListWith (+) $ zip sen $ repeat 1

coolestWord :: [String] -> String
coolestWord =
    fst . maximumBy (\x -> \y -> compare (snd x) (snd y)) . Map.toList . wordCount . concat . map sentenceToWord

sentenceToWord :: String -> [String]
sentenceToWord =
    split


