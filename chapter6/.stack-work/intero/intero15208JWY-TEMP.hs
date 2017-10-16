module Chapter6 where
import           Data.List (sort)

myX = 1 :: Int

sigmund :: Num a => a -> Int
sigmund x = myX

chk :: Eq b =>  (a -> b) -> a -> b -> Bool
chk f x y =
    y == (f x)

arith :: Num b => (a -> b) -> Integer -> a -> b
arith f i x =
   (+) (f x) (fromInteger i)
