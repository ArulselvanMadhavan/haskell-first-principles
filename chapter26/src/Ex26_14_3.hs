module Ex26_14_3 where

import           Control.Monad.Trans.Reader
import           Data.Functor.Identity

rShow :: Show a => ReaderT a Identity String
rShow = ReaderT (Identity . show)
