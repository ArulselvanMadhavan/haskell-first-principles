module Ex1 where

import           Moi

type State' = Moi

get :: State' s s
get = Moi (\s -> (s, s))

put :: s -> State' s ()
put s = Moi (\ss -> ((), s))

exec :: State' s a -> s -> s
exec (Moi sa) = snd . sa

eval :: State' s a -> s -> a
eval (Moi sa) = fst . sa

modify :: (s -> s) -> State' s ()
modify f = Moi (\s -> ((), f s))
