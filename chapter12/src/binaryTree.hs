module BinaryTree where

data BinaryTree a =
    Leaf
  | Node (BinaryTree a) a (BinaryTree a) deriving (Eq, Show)


treeGen :: Integer -> Maybe (Integer,Integer,Integer)
treeGen a
    | a <= 1 = Nothing
    | otherwise =  Just (((div a 2) - 1), a, (div a 2))

treeBuild :: Integer -> Maybe (Integer, Integer, Integer)
treeBuild a
    | a > 10 = Nothing
    | otherwise = Just (a + 1, a , a + 1)

unfold :: (a -> Maybe (a,b,a)) -> a -> BinaryTree b
unfold f a =
    case f a of
      Just (l,c,r) -> Node (unfold f l) c (unfold f r)
      Nothing      -> Leaf
