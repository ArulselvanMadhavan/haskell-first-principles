1. Single fmap signature
```
fmap :: Functor f => (a -> b) -> f a -> f b
```
2. Compose two fmap
```
(fmap . fmap) :: Functor f1, Functor f => (a -> b) -> f1 (f a) -> f1 (f b)
```