{-# LANGUAGE OverloadedStrings #-}

module Scotty where

import           Control.Monad                  (liftM)
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Except
import           Control.Monad.Trans.Reader
import           Control.Monad.Trans.State.Lazy hiding (get)
import           Data.Monoid                    (mconcat)
import           Web.Scotty
import           Web.Scotty.Internal.Types      (ActionT (..))
-- lift :: (Monad m, MonadTrans t) => m a -> t m a
-- lift :: (MonadTrans t) => IO a -> t IO a
-- lift :: IO a -> ActionM a
-- lift :: IO () -> ActionM ()

liftReaderT :: m a -> ReaderT r m a
liftReaderT m = ReaderT (const m)

main =
  scotty 3000 $ do
    get "/:word" $ do
      beam <- param "word"
      (ActionT .
       (ExceptT . fmap Right) .
       (ReaderT . const) .
       (\m ->
          StateT
            (\s -> do
               a <- m
               return (a, s))))
        (putStrLn "hello")
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]

-- v :: (->) a
-- const :: a -> b -> a
-- ReaderT (Monad m):: r m a
-- (const ma) :: r -> ma
-- ReaderT . const :: (ma -> r -> ma)
-- ReaderT . const :: (ReaderT r -> ma)
