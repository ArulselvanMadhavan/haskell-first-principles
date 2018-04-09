# chapter23

### State is a newtype

```haskell
newtype State s a =
        State {runState :: s -> (a, s)}
```

### State from transformers has the following type.
```haskell
state :: Monad m => (s -> (a, s)) -> StateT s m a
```
