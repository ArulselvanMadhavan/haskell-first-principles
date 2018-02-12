{-# LANGUAGE FlexibleInstances #-}

module ChapterEx3 where

data Quant a b
  = Finance
  | Desk a
  | Bloor b

instance Functor (Quant a) where
  fmap f (Bloor b) = Bloor (f b)
  fmap _ (Desk a)  = Desk a
  fmap _ Finance   = Finance

data K a b =
  K a

instance Functor (K a) where
  fmap _ (K a) = K a

newtype Flip f a b =
  Flip (f b a)
  deriving (Eq, Show)

newtype K' a b =
  K' a

instance Functor (Flip K' a) where
  fmap f (Flip (K' a)) = Flip (K' (f a))

data EvilGoateeConst a b =
  GoatyConst b

instance Functor (EvilGoateeConst a) where
  fmap f (GoatyConst b) = GoatyConst (f b)

data LiftItOut f a =
  LiftItOut (f a)
  deriving (Show, Eq)

instance Functor f => Functor (LiftItOut f) where
  fmap g (LiftItOut fa) = LiftItOut (fmap g fa)

data Parappa f g a =
  DaWrappa (f a)
           (g a)
  deriving (Show, Eq)

instance (Functor f, Functor g) => Functor (Parappa f g) where
  fmap ff (DaWrappa x y) = DaWrappa (fmap ff x) (fmap ff y)

data IgnoreOne f g a b =
  IgnoreSomething (f a)
                  (g b)
  deriving (Show, Eq)

instance (Functor g) => Functor (IgnoreOne f g a) where
  fmap f (IgnoreSomething x y) = IgnoreSomething x (fmap f y)

data Notorious g o a t =
  Notorious (g o)
            (g a)
            (g t)

instance (Functor g) => Functor (Notorious g o a) where
  fmap f (Notorious x y z) = Notorious x y (fmap f z)

data List a
  = Nil
  | Cons a
         (List a)
  deriving (Eq, Show)

instance Functor List where
  fmap f Nil         = Nil
  fmap f (Cons a xs) = Cons (f a) (fmap f xs)

data GoatLord a
  = NoGoat
  | OneGoat a
  | MoreGoats (GoatLord a)
              (GoatLord a)
              (GoatLord a)
  deriving (Eq, Show)

instance Functor GoatLord where
    fmap f NoGoat            = NoGoat
    fmap f (OneGoat a)       = OneGoat (f a)
    fmap f (MoreGoats x y z) = MoreGoats (fmap f x) (fmap f y) (fmap f z)

data TalkToMe a =
    Halt
    | Print String a
    | Read (String -> a)

-- instance Functor TalkToMe where
--     fmap f Halt = Halt
--     fmap f (Print s a) = Print s (f a)
--     fmap f (Read g) = Read
