# chapter26 - Monad Transformers

Managing stacks of monad transformers is tricky.

Base Monad - Structurally outermost

```haskell
type MyType a = IO [Maybe a]
-- base Monad is IO
```