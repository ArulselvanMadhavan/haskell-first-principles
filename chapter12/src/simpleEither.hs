module SimpleEither where
import           SimpleMaybe (flippedCons)

isLeft :: Either a b -> Bool
isLeft (Left _) = True
isLeft _        = False

fromLeft :: Either a b -> a
fromLeft (Left a) = a

leftHelper :: Either a b -> [a] -> [a]
leftHelper (Left a) acc = a : acc
leftHelper _ acc        = acc

rightHelper :: Either a b -> [b] -> [b]
rightHelper (Right b) acc = b : acc
rightHelper _ acc         = acc

lefts' :: [Either a b] -> [a]
lefts' =
    foldr leftHelper []

rights' :: [Either a b] -> [b]
rights' =
    foldr rightHelper []

partitionHelper :: Either a b -> ([a], [b]) -> ([a], [b])
partitionHelper (Left a) (as, bs)  = (a : as , bs)
partitionHelper (Right b) (as, bs) = (as , b : bs)

partitionEithers' :: [Either a b] -> ([a], [b])
partitionEithers' =
    foldr partitionHelper ([],[])

eitherMaybe' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe' f (Left _)  = Nothing
eitherMaybe' f (Right b) = Just $ f b

either' :: (a -> c) -> (b -> c) -> Either a b -> c
either' f g (Left a)  = f a
either' f g (Right b) = g b

eitherMaybe'' :: (b -> c) -> Either a b -> Maybe c
eitherMaybe'' g val = either' (\_ -> Nothing) (Just . g) val
