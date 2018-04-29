{-# LANGUAGE InstanceSigs #-}
module EitherT where
import           Control.Applicative

newtype EitherT e m a = EitherT
  { runEitherT :: m (Either e a)
  }

instance Functor m => Functor (EitherT e m) where
  fmap f (EitherT mea) = EitherT $ (fmap . fmap) f mea

instance Applicative m => Applicative (EitherT e m) where
  pure a = EitherT (pure (Right a))
  (<*>) :: EitherT e m (a -> b) -> EitherT e m a -> EitherT e m b
  (EitherT emf) <*> (EitherT ema) = EitherT $ liftA2 (<*>) emf ema

instance Monad m => Monad (EitherT e m) where
  return = pure
  (>>=) :: EitherT e m a -> (a -> EitherT e m b) -> EitherT e m b
  (>>=) (EitherT mea) aemb =
    EitherT $ do
      ea <- mea
      case ea of
        Left e  -> return (Left e)
        Right r -> runEitherT (aemb r)

swapEither :: Either e a -> Either a e
swapEither (Left e)  = Right e
swapEither (Right a) = Left a

swapEitherT :: (Functor m) => EitherT e m a -> EitherT a m e
swapEitherT (EitherT ema) = EitherT (fmap swapEither ema)

eitherT :: (Monad m) => (a -> m c) -> (b -> m c) -> EitherT a m b -> m c
eitherT amc bmc (EitherT amb) = do
  ab <- amb
  case ab of
    Left a  -> amc a
    Right b -> bmc b
