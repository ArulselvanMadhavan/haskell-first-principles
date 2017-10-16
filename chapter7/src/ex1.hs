module Ex1 where

addOneIfOdd n = case odd n of
  True  -> f n
  False -> n
  where f = \n -> n + 1
