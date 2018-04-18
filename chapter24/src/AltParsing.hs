{-# LANGUAGE QuasiQuotes #-}
module AltParsing where

import           Control.Applicative
import           Text.RawString.QQ
import           Text.Trifecta
import           Text.Trifecta

type NumberOrString = Either Integer String

a = "blah"
b = "123"
c = "123blah789"

eitherOr :: String
eitherOr = [r|
123
abc
456
def
|]

parseNos :: Parser NumberOrString
parseNos = (Left <$> integer) <|> (Right <$> some letter)

main :: IO ()
main = do
  let p f i = parseString f mempty i
  let res1 :: Result [Integer]
      res1 = p (some integer) "12893129817123"
  print $ p (some letter) a
  print $ p integer b
  print $ p parseNos a
  print $ p (many parseNos) c
  print $ p (some parseNos) c
  print $ res1
