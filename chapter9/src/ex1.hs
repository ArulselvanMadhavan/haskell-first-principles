module Ex1 where

eftInt :: (Enum a, Ord a) => a -> a -> [a]
eftInt start stop
    | stop < start = []
    | stop == start = [stop]
    | otherwise = start : eftInt (succ start) stop


-- eftBool :: Bool -> Bool -> [Bool]
-- eftBool start stop

