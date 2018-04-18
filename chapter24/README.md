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

## Haskell Parsers
1. parsec
2. attoparsec - (Suitable for production - very speed parsing)
3. megaparsec
4. trifecta - easy to read error messages
4. aeson (JSON)
5. cassava (CSV)

```haskell
class Applicative f => Alternative f where
      empty :: f a
      (<|>) :: f a -> f a -> f a
      some :: f a -> f [a]
      some v = some_v
           where
            many_v = some_v <|> pure []
            some_v = (fmap (:) v) <*> many_v
      many :: f a -> f [a]
      many v = many_v
           where
            many_v = some_v <|> pure []
            some_v = (fmap (:) v) <*> many_v
```