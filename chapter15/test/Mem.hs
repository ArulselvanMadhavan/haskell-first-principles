module Mem where

import           Data.Monoid
import           Test.QuickCheck

newtype Mem s a =
    Mem {
      runMem :: s -> (a, s)
    }

instance (Eq a, Monoid a) => Monoid (Mem s a) where
  mempty = Mem (\s -> (mempty, s))
    -- mappend f g = Mem (\s -> runMem f . snd . runMem g $ s)
  mappend f g =
    Mem
      (\s ->
         let gs = runMem g s
             fs = runMem f (snd gs)
             emps = runMem mempty s
         in case (fst fs == fst emps, fst gs == fst emps) of
              (True, False) -> (fst gs, snd fs)
              (_, _)        -> fs)


f' = Mem $ \s -> ("hi", s + 1)

memAssoc :: (Eq a, Eq s, Monoid a) => Mem s a -> Mem s a -> Mem s a -> s -> Bool
memAssoc a b c val =
  let x = runMem (a <> (b <> c)) $ val
      y = runMem ((a <> b) <> c) $ val
  in x == y

memLeftIdentity :: (Eq a, Eq s, Monoid a) => Mem s a -> s -> Bool
memLeftIdentity f val =
  let x = runMem (f <> mempty) $ val
      y = runMem f $ val
  in x == y

memRightIdentity :: (Eq a, Eq s, Monoid a) => Mem s a -> s -> Bool
memRightIdentity f val =
  let x = runMem f $ val
      y = runMem (f <> mempty) $ val
  in x == y

runTests :: IO ()
runTests = do
    quickCheck ((memRightIdentity f') :: Int -> Bool)
    quickCheck ((memLeftIdentity f') :: Int -> Bool)

visualTests :: IO ()
visualTests = do
    let rmzero = runMem mempty 0
        rmleft = runMem (f' <> mempty) 0
        rmright = runMem (mempty <> f') 0
    print $ rmleft
    print $ rmright
    print $ (rmzero :: (String, Int))
    print $ rmleft == runMem f' 0
    print $ rmright == runMem f' 0

