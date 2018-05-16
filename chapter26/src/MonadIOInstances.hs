module MonadIOInstances where

import           Control.Monad.IO.Class
import           Control.Monad.Trans.Identity (IdentityT)


-- instance (MonadIO m) => MonadIO (IdentityT m) where
--     liftIO = IdentityT . liftIO

-- MaybeT

-- instance (MonadIO m) => MonadIO (MaybeT m) where
--     liftIO = MaybeT . liftIO

-- instance (MonadIO m) => MonadIO (ReaderT r m) where
--     liftIO = lift . liftIO

-- instance (MonadIO m) => MonadIO (StateT s m) where
--     liftIO = lift . liftIO
