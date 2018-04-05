module Bip where

import           Control.Applicative

boop = (*2)
doop = (+10)

-- bip :: Integer -> Integer
bip = boop . doop

bbop :: Integer -> Integer
bbop = (+) <$> boop <*> doop

duwop :: Integer -> Integer
duwop = liftA2 (+) boop doop

--((+) <$> (*2) <*> (+10)) - (a -> a -> b) <$> (a -> a) <*> (a -> a)
--(a -> a -> b) <*> (a -> a)
--(a -> b)
