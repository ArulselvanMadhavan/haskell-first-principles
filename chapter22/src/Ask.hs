module Ask where


newtype Reader r a = Reader
  { runReader :: r -> a
  }

ask :: Reader a a
ask = Reader id

-- pure a = ((->) r a) -- An anonymous function always returning a
-- <*> f (a -> b)  -> f a -> f b
-- <*> ((->) a (a -> b)) -> ((->) a) -> ((->) b)
-- <*> ((->) r (a -> b)) -> ((->) r a) -> ((->) r b)
