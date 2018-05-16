module Ex26_14_6 where

import           Control.Monad.IO.Class
import           Control.Monad.Trans.State

sPrintIncAccum :: (Num s, Show s) => StateT s IO String
sPrintIncAccum = do
  s <- get
  liftIO $ print $ "Hi: " ++ show s
  put (s + 1)
  return $ show s
