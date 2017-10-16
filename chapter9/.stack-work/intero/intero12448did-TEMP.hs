module ZipNew where

zipCustom :: [a] -> [b] -> [(a, b)]
zipCustom xs ys =
    case (xs, ys) of
      ([], [])      -> []
      ([], _)       -> []
      (_, [])       -> []
      (a:as , b:bs) -> (a, b) : (zipCustom as bs)

zipWithCustom :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWithCustom f xs ys =
    case (xs, ys) of
      ([], [])     -> []
      ([], _)      -> []
      (_, [])      -> []
      (a:as, b:bs) -> (f a b) : zipWithCustom f as bs

zipViaZipWith :: [a] -> [b] -> [(a,b)]
zipViaZipWith xs ys =
    zipWithCustom (\x -> \y -> (x,y)) xs ys
