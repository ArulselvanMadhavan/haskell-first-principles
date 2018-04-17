{-# LANGUAGE OverloadedStrings #-}

module Text.Fractions where

import           Control.Applicative
import           Data.Ratio          ((%))
import           Text.Trifecta

badFraction = "1/0"
alsoBad = "10"
shouldWork = "1/20"
shouldAlsoWork = "2/1"

parseFraction :: Parser Rational
parseFraction = do
  num <- decimal
  char '/'
  denom <- decimal
  return (num % denom)

virtuousFraction :: Parser Rational
virtuousFraction = do
  num <- decimal
  char '/'
  denom <- decimal
  case denom of
    0 -> fail "Denom can't be zero" -- fail is part of Monad typeclass.
    _ -> return (num % denom)

main :: IO ()
main = do
  let parseFraction' = parseString parseFraction mempty
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
