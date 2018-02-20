module Cow where
import           Control.Applicative

data Cow = Cow
  { name   :: String
  , age    :: Int
  , weight :: Int
  } deriving (Eq, Show)

noEmpty :: String -> Maybe String
noEmpty ""  = Nothing
noEmpty str = Just str

noNegative :: Int -> Maybe Int
noNegative n
  | n >= 0 = Just n
  | otherwise = Nothing

cowFromString :: String -> Int -> Int -> Maybe Cow
cowFromString n a w =
  case noEmpty n of
    Nothing -> Nothing
    Just nn ->
      case (noNegative a, noNegative w) of
        (Just aa, Just ww) -> Just (Cow n aa ww)
        (_, _)             -> Nothing

cowFromString' :: String -> Int -> Int -> Maybe Cow
cowFromString' n a w =
    Cow <$> noEmpty n <*> noNegative a <*> noNegative w

cowFromString'' :: String -> Int -> Int -> Maybe Cow
cowFromString'' n a w =
    liftA3 Cow (noEmpty n) (noNegative a) (noNegative w)
