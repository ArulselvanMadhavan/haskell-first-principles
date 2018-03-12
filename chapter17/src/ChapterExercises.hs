module ChapterExercises where
import           Control.Applicative      (liftA3)
import           Test.QuickCheck
import           Test.QuickCheck.Checkers

pureList :: a -> [a]
pureList a = [a]

applyList :: [(a -> b)] -> [a] -> [b]
applyList fs xs = (>>=) fs (\f -> fmap f xs)

pureIO :: a -> IO a
pureIO a = return a

-- applyIO :: IO (a -> b) -> IO a -> IO b
pureTuple :: a -> (a, a)
pureTuple a = (a, a)

-- applyTuple :: (c, a -> b) -> (c, a) -> (c, b)
-- pureFunc :: a -> (->) a a
-- applyFunc :: (->) a (a -> b) -> (->) a a -> (->) a b
data Pair a =
  Pair a
       a
  deriving (Eq, Show)

instance Functor Pair where
  fmap f (Pair x1 x2) = Pair (f x1) (f x2)

instance Applicative Pair where
  pure a = Pair a a
  (<*>) (Pair f1 f2) (Pair x1 x2) = Pair (f1 x1) (f2 x2)

instance Arbitrary a => Arbitrary (Pair a) where
  arbitrary = do
    x1 <- arbitrary
    x2 <- arbitrary
    return (Pair x1 x2)

instance (Eq a) => EqProp (Pair a) where
  (=-=) = eq

data Two a b =
  Two a
      b
  deriving (Eq, Show)

instance Functor (Two a) where
  fmap f (Two a b) = Two a (f b)

instance (Monoid a) => Applicative (Two a) where
  pure a = Two (mempty) a
  (<*>) (Two a1 f) (Two a2 b) = Two (a1 `mappend` a2) (f b)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Two a b) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    return (Two a b)

instance (Eq a, Eq b) => EqProp (Two a b) where
  (=-=) = eq

data Three a b c =
  Three a
        b
        c
  deriving (Eq, Show)

instance Functor (Three a b) where
  fmap f (Three a b c) = Three a b (f c)

instance (Monoid a, Monoid b) => Applicative (Three a b) where
  pure a = Three mempty mempty a
  (<*>) (Three a1 b1 f) (Three a2 b2 c) =
    Three (a1 `mappend` a2) (b1 `mappend` b2) (f c)

instance (Arbitrary a, Arbitrary b, Arbitrary c) =>
         Arbitrary (Three a b c) where
  arbitrary = do
    a <- arbitrary
    b <- arbitrary
    c <- arbitrary
    return (Three a b c)

instance (Eq a, Eq b, Eq c) => EqProp (Three a b c) where
  (=-=) = eq

data Three' a b =
  Three' a
         b
         b
  deriving (Eq, Show)

instance Functor (Three' a) where
  fmap f (Three' a b1 b2) = Three' a (f b1) (f b2)

instance (Monoid a) => Applicative (Three' a) where
  pure a = Three' mempty a a
  (<*>) (Three' a1 f1 f2) (Three' a2 b1 b2) =
    Three' (a1 `mappend` a2) (f1 b1) (f2 b2)

instance (Arbitrary a, Arbitrary b) => Arbitrary (Three' a b) where
    arbitrary = do
        a <- arbitrary
        b <- arbitrary
        b2 <- arbitrary
        return (Three' a b b2)

instance (Eq a, Eq b) => EqProp (Three' a b) where
    (=-=) = eq

stops :: String
stops = "pbtdkg"

vowels :: String
vowels = "aeiou"

combos :: [a] -> [b] -> [c] -> [(a,b,c)]
combos xs ys zs =
    liftA3 (,,) xs ys zs
