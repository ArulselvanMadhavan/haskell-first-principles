module Ex26_14_2 where

import           Control.Monad.Trans.Reader
import           Data.Functor.Identity

rDec :: Num a => Reader a a
rDec = ReaderT (Identity . (flip (-)) 1)
