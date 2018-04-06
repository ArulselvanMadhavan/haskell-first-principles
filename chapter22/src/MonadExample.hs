module MonadExample where

foo :: (Functor f, Num a) => f a -> f a
foo r = fmap (+1) r

bar :: (Foldable f) => t -> f a -> (t, Int)
bar r t = (r, length t)

froot :: Num a => [a] -> ([a], Int)
froot r = (map (+ 1) r, length r)

barOne :: Foldable t => t a -> (t a, Int)
barOne r = (r, length r)
