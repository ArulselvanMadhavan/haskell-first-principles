# chapter24 - Parser Combinators

1. Parser Combinator is a HOF that takes parsers as input and returns a new parser as output.

Parser definition
```haskell
type Parser a = String -> Maybe (a, String)
```

```haskell
newtype Reader a = {runReader :: r -> a}
```

```haskell
newtype State s a = {runState :: s -> (a, s)}
```

```haskell
-- from Text.ParserCombinators.HuttonMeijer
-- polyparse-1.11

type Token = Char
newtype Parser a =
        P ([Token] -> [(a, [Token])])

type Parser' a = String -> [(a, String)]
```
