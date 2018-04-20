module TryTry where
import           Control.Applicative
import           Data.Ratio          ((%))
import           Numeric
import           Text.Trifecta


type DecimalOrFraction = Either Integer Rational

parseDecimal :: Parser Rational
parseDecimal = do
  num <- decimal
  char '/'
  denom <- decimal
  case denom of
    0 -> fail "Denom can't be zero"
    _ -> return (num % denom)

getFractionAsRational :: Integer -> Rational
getFractionAsRational f =
  let num = ((^) 10) . length . show $ f
  in (f % num)

parseFraction :: Parser Rational
parseFraction = do
  num <- decimal
  char '.'
  denom <- decimal
  return $ (num % 1) + (getFractionAsRational denom)

successInteger :: Parser Integer
successInteger = do
  i <- integer
  eof
  return i

parseIntegerOrRational :: Parser DecimalOrFraction
parseIntegerOrRational =
  (Left <$> try successInteger) <|> (Right <$> try parseDecimal) <|>
  (Right <$> try parseFraction)

main :: IO ()
main = do
  let p f i = parseString f mempty i
  print $ p parseIntegerOrRational "43"
  print $ p parseIntegerOrRational "117.67"
  print $ p parseIntegerOrRational "23/5"
  print $ p parseIntegerOrRational "1238713.12.14" -- Ignores the values after second "."
