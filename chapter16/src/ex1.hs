module Ex1 where

e :: IO Integer
e =
  let ioi = readIO "1" :: IO Integer
      changed = (read . ("123" ++) . show) ioi
  in (*3) changed
