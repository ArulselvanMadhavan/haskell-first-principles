# chapter22 - Reader

1. The Functor of functions is function composition.
2. The Applicative and Monad chain the argument forward in addition to the composition.

Reader - It is a way of stringing functions together when all those functions are awaiting one input from a shared environment. It's another way of abstracting out function application and gives us a way to do computation in terms of an argument that hasn't been supplied yet.

```
Reader is a newtype wrapper for the function type
```

```haskell
newtype Reader r a =
        Reader { runReader :: r -> a }

instance Functor (Reader r) where
         fmap :: (a -> b) -> Reader r a -> Reader r b
         fmap f (Reader ra) = Reader $ \r -> f (ra r)
```

```haskell
(>>=) :: Monad m => m a -> (a -> m b) -> m b
(>>=) :: (->) r a -> (a -> (->) r b) -> (->) r b
(>>=) :: (r -> a) -> (a -> r -> b) -> r -> b

return :: Monad m => a -> m a
return :: a -> (->) r a
return :: a -> r -> a
```

## Applicative vs Monad for Reader
```haskell
<*> :: (r -> a -> b) -> (r -> a) -> (r -> b)
(>>=) :: (->) r a -> (a -> (->) r b) -> (r -> b)
(>>=) :: (r -> a) -> (a -> r -> b) -> (r -> b)
(=>>) :: (a -> r -> b) -> (r -> a) -> (r -> b)
```

```Reader Monad by itself is boring because it can't do anything that the Applicative can't```