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
def
|]


type NumberOrString = Either Integer String

parseNos :: Parser NumberOrString
parseNos = (Left <$> integer) <|> (Right <$> some letter)

main :: IO ()
main = do
  let p f i = parseString f mempty i
  print $ p parseNos eitherOr
