# Haskell Handbook

### Add package
```bash
stack install QuickCheck
```

### Load Tests
```bash
stack ghci <project_name>:<test_module_name>
```

### Monoid
Applied on a per operation basis
1. Binary
2. Associative
3. Idenity

### Semigroup
A monoid where the Identity property is left out.

### Magma
Magma < Semigroup < Monoid

### Functor
A way to apply a function over or around some structure that we don't want to alter.

Functor laws - <$> - Function application over a structure
```hs
fmap id = id
fmap (p . q) = (fmap p) . (fmap q)
```

Functor instances are unique for a given datatype as opposed to monoid which is unique per operation.

QuickCheck
1. Arbitrary typeclass is used for generating values
2. CoArbitrary typeclass is used for generating functions

Applicative
1. Applicatives are monoidal functors.

```haskell
class Functor f => Applicative f where
      pure :: a -> f a
      <*>  :: f (a -> b) -> f a -> f b
```
2. Comparison with Functor
```haskell
(<$>) :: Functor f
      => (a -> b) -> f a -> f b
(<*>) :: Applicative f
      => f (a -> b) -> f a -> f b
```


### TODO
1. I haven't done Chapter16 Chapter Exercise 11.