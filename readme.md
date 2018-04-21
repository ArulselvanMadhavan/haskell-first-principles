# Haskell Handbook

### Add package
```bash
stack install QuickCheck
```

### Load Tests
```bash
stack ghci <project_name>:<test_module_name>
```

### To make GHC notice changes to package.yaml
```bash
stack build
```

### To enable QuasiQuotes
```haskell
:set -ddump-splices
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

### Applicative
1. Applicatives are monoidal functors.

```haskell
class Functor f => Applicative f where
      pure :: a -> f a
      <*>  :: f (a -> b) -> f a -> f b
```
2. <*> - is called "apply".
3. Comparison with Functor
```haskell
(<$>) :: Functor f
      => (a -> b) -> f a -> f b
(<*>) :: Applicative f
      => f (a -> b) -> f a -> f b
```

### Applicative Laws
1. Identity
```haskell
pure id <*> v = v
```
2. Composition
```haskell
pure (.) <*> u <*> v <*> w =
     u <*> (v <*> w)
```
3. Homomorphism
```haskell
pure f <*> pure x = pure (f x)
```
4. Interchange
```haskell
u <*> pure y = pure ($ y) <*> u
```

1. Applicative is just function application that preserves without doing anything other than
combining the structure bits.
2. Applicative can have more than one valid and lawful instance for a given datatype.

```quote
Applicative can be thought of characterizing Monoidal Functors in Haskell
```

## Monad

[Notes on Monad](chapter18/README.md)

## Foldable
[Notes on Foldable](chapter19/README.md)

## Traversable
[Notes on Traversable](chapter20/README.md)

### TODO
1. I haven't done Chapter16 Chapter Exercise 11.
2. Chapter 21 - Tests for Exercise SkiFree are failing.
3. Chapter 21 - Need to write Arbitrary Instance for Tree and finish the test.
