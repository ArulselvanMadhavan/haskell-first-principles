module Playground where

import           Data.Char

cap :: [Char] -> [Char]
cap xs = map toUpper xs

rev :: [Char] -> [Char]
rev xs = reverse xs

composed :: [Char] -> [Char]
composed = rev . cap

fmapped :: [Char] -> [Char]
fmapped = fmap cap rev

tupled :: [Char] -> ([Char], [Char])
tupled = (,) <$> cap <*> rev

tupledMonadic :: [Char] -> ([Char], [Char])
tupledMonadic = do
  a <- cap
  b <- rev
  return $ (a, b)

tupledMonadic' :: [Char] -> ([Char], [Char])
tupledMonadic' xs =
    (return (cap xs)) >>=
    \c -> (return (rev xs)) >>=
    \r -> (c, r)
