# chapter18 - Monads

1. Monads are applicative functors.

```haskell
class Applicative m => Monad m where
    (>>=) :: m a -> (a -> m b) -> m b --Binding Operation
    (>>) :: m a -> m b -> m b  --Sequencing Operation
    return :: a -> m a
```

### fmap using Monadic Operations
```haskell
fmap f xs = xs >>= return . f
```

### Dependency Chain
```bash
Functor -> Applicative -> Monad
```

* Eventhough there are three monadic operations, we only (>>=) to be a minimally complete monad instance.

* 
```haskell 
join :: Monad m => m (m a) => m a
```

*
```haskell
bind :: Monad m => (a -> m b) -> m a -> m b
bind f xs =
     join $ fmap f xs
```

* Monad is not impure.
* Monad is not an embedded language for doing impure programming.
* Monad is not a value. It's a typeclass just like functor, applicative.
* Monad is not about strictness.

## Identity Laws

```haskell
m >>= return = m
return x >> = f = f x
```

## Associativity Law

```haskell
(m >>= f) >>= g = m >>= (\x -> f x >>= g)
```

### Monadic Composition
```haskell
mcomp :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
mcomp f g a = g a >>= f
```              

```haskell
(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
```
