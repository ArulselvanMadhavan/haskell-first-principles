# chapter20 - Foldable

1. Lists are not the only foldable data structures.
2. Folding function is always dependent on some Monoid instance.
```
Generalizing catamorphisms to other datatypes depends on understanding monoids for other structures and in some cases, making them explicit
```

```haskell
class Foldable (t :: * -> *) where
      {-# MINIMAL foldMap | foldr #-}
      fold :: Monoid m => t m => m
      foldMap :: Monoid m => (a -> m) -> t a -> m
```
3. Folding necessarily implies a binary associative operation that has an identity value.
