module Ex2 where
import           Control.Monad (join, liftM, liftM2)

j :: Monad m => m (m a) -> m a
-- j = mma >>= (\ma -> ma >>= return)
j = (=<<) $ (=<<) return

l1 :: Monad m => (a -> b) -> m a -> m b
l1 = fmap

l2 :: Monad m => (a -> b -> c) -> m a -> m b -> m c
-- l2 ff ma mb = ma >>= (\a -> mb >>= (\b -> return (ff a b)))
-- l2 ff ma mb = ma >>= (\a -> (mb >>= (return . (ff a))))
l2 ff ma mb = ma >>= (\a -> mb >>= (\b -> return $ ff a b))

a :: Monad m => m a -> m (a -> b) -> m b
-- a ma mf = ma >>= (\a -> mf >>= \f -> return $ f a)
a ma mf = mf >>= (\f -> ma >>= (return . f))

meh :: Monad m => [a] -> (a -> m b) -> m [b]
meh [] f     = return []
-- meh (a:as) f = (f a) >>= (\b -> (meh as f) >>= (\bs -> return $ b : bs))
meh (a : as) f = (f a)
    >>= (\b -> (meh as f)
        >>= (\bs -> return $ (b : bs)))

flipType :: (Monad m) => [m a] -> m [a]
flipType mas =
    meh mas id
