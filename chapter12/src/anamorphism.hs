module Anamorphism where

myIterate :: (a -> a) -> a -> [a]
myIterate f a =
    a : myIterate f (f a)

unfoldr :: (b -> Maybe (a, b)) -> b -> [a]
unfoldr f b =
    case f b of
      Just (a, b1) -> a : unfoldr f b1
      Nothing      -> []

betterIterate :: (a -> a) -> a -> [a]
betterIterate f x =
    unfoldr (\b -> Just (b , f b)) x
