module Ex3 where

data BinaryTree a =
    Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Show, Ord)


insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
    | b == a = Node left a right
    | b < a  = Node (insert' b left) a right
    | b > a  = Node left a (insert' b right)

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) =
    Node (mapTree f left) (f a) (mapTree f right)


testTree' :: BinaryTree Integer
testTree' =
    Node
    (Node Leaf 3 Leaf)
    1
    (Node Leaf 4 Leaf)

preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node left a right) =
    [a] ++ (preorder left) ++ (preorder right)

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left a right) =
    (inorder left) ++ [a] ++ (preorder right)

t1 = insert' 0 Leaf
t2 = insert' 2 t1
t3 = insert' (-1) t2

testTree :: BinaryTree Integer
testTree = t3

testPreorder :: IO()
testPreorder =
    if preorder testTree' == [1, 3, 4]
    then putStrLn "Preorder fine!"
    else putStrLn "Bad news bears."

foldTree :: (a -> b -> b) -> b -> BinaryTree a -> b
foldTree f b Leaf = b
foldTree f b (Node left a right) =
    flip (foldTree f) right . f a . foldTree f b $ left
