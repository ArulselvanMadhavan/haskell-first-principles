module Ex4 where

indexOf :: (Eq a) => a -> [a] -> Int
indexOf a =
    foldr (\x -> \y -> if (a == x) then 0 else (if y /= (-1) then y + 1 else y)) (-1)

-- isSubseqOf :: (Eq a) => [a] -> [a] -> Bool
-- isSubseqOf srch str =
-- isSubseqOf [] _ =
