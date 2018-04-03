module TreeInstance where
import           Data.Monoid
import           Test.QuickCheck
import           Test.QuickCheck.Checkers

data Tree a
  = Empty
  | Leaf a
  | Node (Tree a)
         a
         (Tree a)
  deriving (Eq, Show)

instance Functor Tree where
  fmap f Empty          = Empty
  fmap f (Leaf a)       = Leaf $ f a
  fmap f (Node t1 a t2) = Node (fmap f t1) (f a) (fmap f t2)

instance Applicative Tree where
  pure a = Leaf a
  (<*>) (Leaf f) (Leaf a)             = Leaf $ f a
  (<*>) (Node f1 f f2) (Node t1 a t2) = Node (f1 <*> t1) (f a) (f2 <*> t2)

instance Foldable Tree where
  foldMap f Empty          = mempty
  foldMap f (Leaf a)       = f a
  foldMap f (Node t1 a t2) = (foldMap f t1) <> (f a) <> (foldMap f t2)

instance Traversable Tree where
  traverse f Empty = pure Empty
  traverse f (Leaf a) = Leaf <$> f a
  traverse f (Node t1 a t2) =
    Node <$> (traverse f t1) <*> f a <*> (traverse f t2)

instance Arbitrary a => Arbitrary (Tree a) where
    arbitrary = do
        a <- arbitrary
        elements [Empty, Leaf a]

instance (Eq a) => EqProp (Tree a) where
    (=-=) = eq
