module FixerUpper where

p1 = const <$> Just "Hello" <*> pure "World"
-- p2 = (,,,) <*> Just 90 <$>  Just 10 <$>  Just "Tierness" <$> pure [1,2,3]
p2 = (,,,) <$> Just 90 <*> Just 10 <*> Just "Tierness" <*> pure [1,2,3]
