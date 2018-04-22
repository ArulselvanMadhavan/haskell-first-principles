# chapter25 - Composing Types

1. Functors and Applicative are composable. This is not true of monads.
2. If you compose monads, the result may not be a monad.
3. Composing monads is still desirable.
4. Composing monads allows you to build up computations with multiple effects.

*Monad transformer is a variant of an ordinary type(aka type constructor) that takes an additional type argument with is assumed to have a monad instance.*
Ex: MaybeT is a transformer variant of Maybe

1. The transformer variant of a type gives us a Monad instance that binds over both bits of structure.
2. This allows us to compose monads and combine their effects.

## Identity is boring
