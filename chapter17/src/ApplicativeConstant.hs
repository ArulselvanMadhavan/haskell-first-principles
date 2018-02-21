module ApplicativeConstant where

newtype Sum a = Sum
  {
      getSum :: a
  } deriving (Eq, Show)

instance (Num a) => Monoid (Sum a) where
  mempty = Sum 0
  mappend (Sum x) (Sum y) = Sum (x + y)

newtype Constant a b = Constant
  { getConstant :: a
  } deriving (Eq, Ord, Show)

instance Functor (Constant a) where
    fmap f (Constant a) = Constant a

instance Monoid a => Applicative (Constant a) where
    pure a = Constant mempty
    (<*>) (Constant a1) (Constant a2) = Constant (a1 `mappend` a2)
