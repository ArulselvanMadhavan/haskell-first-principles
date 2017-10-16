{-# LANGUAGE NoMonomorphismRestriction#-}
module DetermineTheType where

x = 5
y = x + 5
z y = y * 10

f = 4 / y
