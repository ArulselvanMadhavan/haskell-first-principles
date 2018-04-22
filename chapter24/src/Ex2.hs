module Ex2 where

import           Text.Trifecta

parseDigit :: Parser Char
parseDigit = do
  oneOf "-0123456789"

base10Integer :: Parser Integer
base10Integer = do
  l <- some parseDigit
  case l of
    [] -> fail "Expected a digit"
    _  -> return $ read l
