module Bip where

import           Control.Applicative

boop = (*2)
doop = (+10)

-- bip :: Integer -> Integer
bip = boop . doop
