{-# LANGUAGE OverloadedStrings #-}

module Text.Fractions where

import           Control.Applicative
import           Data.Attoparsec.Text (parseOnly)
import           Data.Ratio           ((%))
import           Data.String          (IsString)
import           Text.Trifecta

badFraction :: IsString s => s
badFraction = "1/0"

alsoBad :: IsString s => s
alsoBad = "10"

shouldWork :: IsString s => s
shouldWork = "1/20"

shouldAlsoWork :: IsString s => s
shouldAlsoWork = "2/1"

parseFraction :: (Monad m, TokenParsing m) => m Rational
parseFraction = do
  num <- decimal
  char '/'
  denom <- decimal
  return (num % denom)

virtuousFraction :: (Monad m, TokenParsing m) => m Rational
virtuousFraction = do
  num <- decimal
  char '/'
  denom <- decimal
  case denom of
    0 -> fail "Denom can't be zero" -- fail is part of Monad typeclass.
    _ -> return (num % denom)

main :: IO ()
main = do
  let attoP = parseOnly virtuousFraction
  print $ attoP badFraction
  print $ attoP shouldWork
  print $ attoP shouldAlsoWork
  print $ attoP alsoBad
  let parseFraction' = parseString virtuousFraction mempty
  print $ parseFraction' shouldWork
  print $ parseFraction' shouldAlsoWork
  print $ parseFraction' alsoBad
  print $ parseFraction' badFraction

testVirtuous :: IO ()
testVirtuous = do
  let parseFraction' = parseString virtuousFraction mempty
  print $ parseFraction' alsoBad
  print $ parseFraction' badFraction
  print $ parseFraction' shouldWork
  print $ parseFraction' shouldAlsoWork

successInteger :: Parser Integer
successInteger = do
  i <- integer
  eof
  return i

parseInteger :: IO ()
parseInteger = do
  let parseFraction' = parseString successInteger mempty
  print $ parseFraction' "123abc"
  print $ parseFraction' "12345"
