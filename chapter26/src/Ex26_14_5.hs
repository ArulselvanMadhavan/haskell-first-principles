module Ex26_14_5 where

import           Control.Monad.IO.Class
import           Control.Monad.Trans.Reader

rPrintAndInc' :: (Num a, Show a) => ReaderT a IO a
rPrintAndInc' = ReaderT $ do \r -> return (r + 1)

rPrintAndInc :: (Num a, Show a) => ReaderT a IO a
rPrintAndInc = do
    r <- ask
    liftIO $ print $ "Hi: " ++ show r
    return (r + 1)
