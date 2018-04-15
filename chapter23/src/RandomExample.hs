module RandomExample where

import           Control.Applicative       (liftA3)
import           Control.Monad             (replicateM)
import           Control.Monad.Trans.State
import           System.Random


data Die =
    DieOne
    | DieTwo
    | DieThree
    | DieFour
    | DieFive
    | DieSix
    deriving (Eq, Show)

intToDie :: Int -> Die
intToDie n =
    case n of
      1 -> DieOne
      2 -> DieTwo
      3 -> DieThree
      4 -> DieFour
      5 -> DieFive
      6 -> DieSix
      x -> error $ "intToDie got 1-6 non-integer" ++ show x

rollDie :: State StdGen Die
rollDie =
    state $ do
    (n, s) <- randomR (1, 6) --StdGen -> (Int, StdGen)
    return (intToDie n, s) --StdGen -> (Die, StdGen)

rollDieThreeTimes' :: State StdGen (Die, Die, Die)
rollDieThreeTimes' = liftA3 (,,) rollDie rollDie rollDie

infiniteDie :: State StdGen [Die]
infiniteDie = repeat <$> rollDie

nDie :: Int -> State StdGen [Die]
nDie n = replicateM n rollDie

rollsToGetTwenty :: StdGen -> Int
rollsToGetTwenty g = go 0 0 g
  where
    go :: Int -> Int -> StdGen -> Int
    go sum count gen
      | sum >= 20 = count
      | otherwise =
        let (die, nextGen) = randomR (1, 6) gen
        in go (sum + die) (count + 1) nextGen

rollsToGetN :: Int -> StdGen -> Int
rollsToGetN n g = go 0 0 g
    where
        go :: Int -> Int -> StdGen -> Int
        go sum count gen
            | sum >= n = count
            | otherwise =
              let (die, nextGen) = randomR (1, 6) gen
              in go (sum + die) (count + 1) nextGen

rollsCountLogged :: Int -> StdGen -> (Int, [Die])
rollsCountLogged n g = go 0 (0, []) g
  where
    go :: Int -> (Int, [Die]) -> StdGen -> (Int, [Die])
    go sum result gen
      | sum >= n = result
      | otherwise =
        let (die, nextGen) = randomR (1, 6) gen
        in go
             (sum + die)
             ((fst result) + 1, (intToDie die) : (snd result))
             nextGen
