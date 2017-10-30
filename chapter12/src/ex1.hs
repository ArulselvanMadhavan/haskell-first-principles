module Ex1 where
import           Data.List

splitWord :: Char -> Char -> (String, [String]) -> (String, [String])
splitWord x y acc =
    case x == y of
      True  -> ("", (fst acc) : (snd acc))
      False -> (y : (fst acc), snd acc)

appendLastWord :: (String, [String]) -> [String]
appendLastWord (x, xs) = x : xs

split :: Char -> String -> [String]
split c =
    appendLastWord . foldr (splitWord c)  ("", [])

notThe :: String -> Maybe String
notThe "the" = Nothing
notThe x     = Just x

applyReplaceMent :: Maybe String-> String
applyReplaceMent (Just x) = x
applyReplaceMent Nothing  = "a"

replaceThe :: String -> String
replaceThe =
    intercalate " " . map applyReplaceMent . map notThe . split ' '
