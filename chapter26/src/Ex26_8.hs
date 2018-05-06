module Ex26_8 where

import           Control.Monad.Trans.Except
import           Control.Monad.Trans.Maybe
import           Control.Monad.Trans.Reader

-- embedded :: MaybeT (ExceptT String (ReaderT () IO)) Int
-- embedded = MaybeT (ExceptT (ReaderT (\() -> (const (Right (Just 1)) ()))))

embedded1 :: ReaderT () IO Int
-- embedded1 = ReaderT (\_ -> return 1)
embedded1 = ReaderT (const $ return 1)

embedded2 :: ExceptT String (ReaderT () IO) Int
embedded2 = ExceptT (ReaderT (const (return (Right 1))))

embedded :: MaybeT (ExceptT String (ReaderT () IO)) Int
embedded = MaybeT (ExceptT (ReaderT (const (return (Right (Just 1))))))
