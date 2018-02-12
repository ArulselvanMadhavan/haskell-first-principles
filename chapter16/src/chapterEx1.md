### Solutions

1. No. Functor instances can't be made. Because it's not a higher kinded type.
```haskell
data Bool =
     False | True
```
2. Yes.
```haskell
data BoolAndSomethingElse a = 
     False' a | True' a
```

3. Yes
```haskell
data BoolAndMaybeComethingElse a =
     Falsish | Truish a
```

4. Not sure. I think so. The 
```haskell
newtype Mu f = InF {outF :: f (Mu f)}

:k My
(* -> *) -> *

The first argument looks like it's going to be a function.
Function passed to fmap can be applied to another function and a result can be produced. This will put restrictions on the function that will passed to fmap.
```

4. No.
```haskell
data D = D (Array Word Word) Int Int
```