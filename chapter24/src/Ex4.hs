module Ex4 where

import           Control.Applicative
import qualified Data.List.Split     as L
import           Text.Trifecta

type NumberingPlanArea = Int
type Exchange = Int
type LineNumber = Int

data PhoneNumber =
  PhoneNumber NumberingPlanArea
              Exchange
              LineNumber
  deriving (Eq, Show)

mkPhoneNumber :: [[Char]] -> PhoneNumber
mkPhoneNumber (x1 : x2 : x3 : []) = PhoneNumber (read x1) (read x2) (read x3)
mkPhoneNumber _                   = PhoneNumber 0 0 0

parseAllNums :: Parser PhoneNumber
parseAllNums = do
  try $ do
    xs <- count 10 digit
    -- You don't have to parse and count. You can count first and fail
    -- fast
    return $ mkPhoneNumber . L.splitPlaces [3, 3, 4] $ xs

parseHyphenated :: Parser PhoneNumber
parseHyphenated = do
  try $ do
    x1 <- count 3 digit
    char '-'
    x2 <- count 3 digit
    char '-'
    x3 <- count 4 digit
    return $ PhoneNumber (read x1) (read x2) (read x3)

parseWithBrackets :: Parser PhoneNumber
parseWithBrackets = do
  try $ do
    char '('
    x1 <- count 3 digit
    char ')'
    many $ char ' '
    x2 <- count 3 digit
    oneOf "- "
    x3 <- count 3 digit
    return $ PhoneNumber (read x1) (read x2) (read x3)

parseWithCountryCode :: Parser PhoneNumber
parseWithCountryCode = do
  try $ do
    _ <- digit
    char '-'
    parseHyphenated

parsePhone :: Parser PhoneNumber
parsePhone = do
  parseAllNums <|> parseHyphenated <|> parseWithBrackets <|> parseWithCountryCode
