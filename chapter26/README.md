# chapter26 - Monad Transformers

Managing stacks of monad transformers is tricky.

Base Monad - Structurally outermost

```haskell
newtype MaybeT = MaybeT {runMaybeT :: m (Maybe a)}
newtype StateT = StateT {runStateT :: s -> m (a, s)}
newtype ReaderT = ReaderT {runReaderT :: r -> m a}
```

```haskell
type MyType a = IO [Maybe a]
-- base Monad is IO
```

## MonadTrans
```haskell
class MonadTrans t where
      -- Lift a computation from the argument monad to the constructed monad
      lift :: (Monad m) => m a -> t m a
```

```haskell
liftM :: Monad m => (a -> r) -> m a -> m r
```

## MonadIO
```haskell
class (Monad m) => MonadIO m where
      -- Lift a computation from the IO monad
      liftIO :: IO a -> m a

liftIO :: IO a -> StateT s (ReaderT r IO) a
liftIO :: IO a -> ExceptT e (StateT s (ReaderT r IO)) a
```

### Transform only if you have to
1. Most of the time you can get by with `liftIO` and plain `IO` actions, functions, `Maybe` values.
2. Do the simplest thing first