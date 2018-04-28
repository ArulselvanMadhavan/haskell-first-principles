{-# LANGUAGE InstanceSigs #-}
module MaybeT where
import           Control.Applicative

newtype Identity a =
  Identity a
  deriving (Eq, Show)

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
  pure = Identity
  (<*>) (Identity f) (Identity a) = Identity (f a)

newtype MaybeT m a = MaybeT
  { runMaybeT :: m (Maybe a)
  }

instance Functor m => Functor (MaybeT m) where
  fmap f (MaybeT ma) = MaybeT $ (fmap . fmap) f ma

instance Applicative m => Applicative (MaybeT m) where
  pure a = MaybeT (pure (Just a))
  (<*>) :: MaybeT m (a -> b) -> MaybeT m a -> MaybeT m b
  (<*>) (MaybeT mf) (MaybeT ma) = MaybeT $ liftA2 (<*>) mf ma
  -- (<*>) (MaybeT mab) (MaybeT ma) = MaybeT $ (<*>) <$> mab <*> ma

instance (Monad m) => Monad (MaybeT m) where
  return = pure
  (MaybeT ma) >>= amb =
    MaybeT $ do
      v <- ma
      case v of
        Nothing -> return Nothing -- m Maybe b
        Just a  -> runMaybeT . amb $ a -- m Maybe b


      -- The below code is an example breakdown
innerMost :: [Maybe (Identity (a -> b))] -> [Maybe (Identity a -> Identity b)]
innerMost = (fmap . fmap) (<*>)

second' :: [Maybe (Identity a -> Identity b)] -> [Maybe (Identity a) -> Maybe (Identity b)]
second' = fmap (<*>)

final' ::
     [Maybe (Identity a) -> Maybe (Identity b)]
  -> [Maybe (Identity a)]
  -> [Maybe (Identity b)]
final' = (<*>)

lmiApply :: [Maybe (Identity (a -> b))] -> [Maybe (Identity a)] -> [Maybe (Identity b)]
lmiApply f x = final' (second' (innerMost f)) x
