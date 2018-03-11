# chapter17

type E = Either
(<*>) :: f (a -> b) -> f a -> f b
(<*>) :: E e (a -> b) -> E e a -> E e b

pure :: a -> E e a

```haskell
data Validation err a =
     Failure err
     Success a
     deriving (Eq, Show)
```

Validation and Either differ only in their Applicative Instance.

```haskell
validToEither :: Validation e a -> Either e a
validToEither (Failure err) = Left err
validToEither (Success a) = Right a

eitherToValid :: Either e a -> Validation e a
eitherToValid (Left e) = Failure e
eitherToValid (Right a) = Success a

eitherToValid . validToEither == id
validToEither . eitherToValid == id
```

```haskell
data Errors =
     DividedByZero
   | StackOverflow
   | MooglesChewedWires
   deriving (Eq, Show)
```
