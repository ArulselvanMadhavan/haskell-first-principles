module SimpleMaybe where
import           Data.Maybe (fromJust)

isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust _        = False

isNothing :: Maybe a -> Bool
isNothing =
    not . isJust

mayybee :: b -> (a -> b) -> Maybe a -> b
mayybee b f val =
    case val of
      Just a  -> f a
      Nothing -> b

fromMaybe :: a -> Maybe a -> a
fromMaybe a =
    mayybee a id

flippedCons :: [a] -> a -> [a]
flippedCons = flip (:)

catMaybes :: [Maybe a] -> [a]
catMaybes =
    foldr (\x -> \acc -> mayybee acc (flippedCons acc) x) []

checkMaybe :: Maybe a -> Maybe [a] -> Maybe [a]
checkMaybe x acc =
    case (acc, x) of
      (Nothing, _)      -> Nothing
      (Just _, Nothing) -> Nothing
      (Just as, Just a) -> Just (a : as)

flipMaybe :: [Maybe a] -> Maybe [a]
flipMaybe =
    foldr checkMaybe (Just [])

    

