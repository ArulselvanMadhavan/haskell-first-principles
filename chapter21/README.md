
# chapter21 - Traversable

Traversable allows you to transform elements inside structure like a functor producint applicative effects along the way and lift those potentially multiple instances of applicative structure outside of the traversable structure.

```haskell
class (Functor t, Foldable f) w=> Traversable t where
      traverse :: Applicative f => (a -> f b) -> t a -> f (t b)
      traverse f = sequenceA . fmap f
      -- | Evaluate each action in the structure from left to right and collect results
      sequenceA :: Applicative f => t (f a) -> f (t a)
      sequenceA = traverse id
      {-# MINIMAL traverse | sequenceA #-}
```
