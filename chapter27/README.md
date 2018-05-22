# chapter27 - Non Strictness

### What is a Thunk?
1. A thunk is used to reference suspended computations that might be performed or computed at a later point in your program.
2. Thunks are computations not yet evaluated upto weak head normal form.

```haskell
sprint -- useful to find out when a computation is thunked.
```
