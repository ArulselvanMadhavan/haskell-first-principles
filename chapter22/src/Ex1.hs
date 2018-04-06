{-# LANGUAGE InstanceSigs #-}
module Ex1 where

newtype Reader r a =
    Reader {runReader :: r -> a}

myLiftA2 :: Applicative f => (a -> b -> c) -> f a -> f b -> f c
myLiftA2 f a b = f <$> a <*> b

asks :: (r -> a) -> Reader r a
asks = Reader

instance Functor (Reader r) where
  fmap :: (a -> b) -> Reader r a -> Reader r b
  fmap ab (Reader ra) = Reader (ab . ra)

instance Applicative (Reader r) where
  pure :: a -> Reader r a
  pure a = Reader (\r -> a)
  (<*>) :: Reader r (b -> c) -> Reader r b -> Reader r c
  (<*>) (Reader rbc) (Reader rb) = Reader (\r -> (rbc r) . rb $ r)

-- (DogName -> Address -> Dog) <$> (Person -> DogName) <*> (Person -> Address)
-- (Person -> Address -> Dog) <*> (Person -> Address)
-- (Person -> Address)


instance Monad (Reader r) where
  return :: a -> Reader r a
  return = pure
  (>>=) (Reader ra) arb = Reader (\r -> (flip ($) r) . runReader . arb . ra $ r)
