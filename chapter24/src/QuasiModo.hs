{-# LANGUAGE QuasiQuotes #-}

module QuasiModo where
import           Control.Applicative
import           Text.RawString.QQ
import           Text.Trifecta

eitherOr :: String
eitherOr = [r|
123
abc
456
def|]


type NumberOrString = Either Integer String

parseNos :: Parser NumberOrString
parseNos = do
  skipMany (oneOf "\n")
  v <- (Left <$> integer) <|> (Right <$> some letter)
  skipMany (oneOf "\n")
  return v

main :: IO ()
main = do
  let p f i = parseString f mempty i
  print $ p (some parseNos) eitherOr
