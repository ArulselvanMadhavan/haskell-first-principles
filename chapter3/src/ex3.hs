module TextOps where

exclaim :: String -> String
exclaim s =
  (++) s "!"

getIndex :: String -> Int -> Char
getIndex s n =
  (!!) s n

getLastWord :: String -> Int -> String
getLastWord s n =
  drop n s

rvrs :: String -> String
rvrs s =
  let curry = take 5 s
      is = take 2 $ drop 6 s
      awesome = take 8 $ drop 9 s
  in
    concat [awesome, " ", is, " ", curry]

