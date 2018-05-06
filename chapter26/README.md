# chapter26 - Monad Transformers

Managing stacks of monad transformers is tricky.

Base Monad - Structurally outermost

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

## MonadIO
```haskell
class (Monad m) => MonadIO m where
      -- Lift a computation from the IO monad
      liftIO :: IO a -> m a
```