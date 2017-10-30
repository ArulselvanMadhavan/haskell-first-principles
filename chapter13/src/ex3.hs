import           Control.Monad   (forever)
import           Data.Char       (toLower)
import qualified Data.List.Split as Split

palindrome :: IO ()
palindrome = forever $ do
    line1 <- getLine
    let cleanLine = map toLower . filter (\x -> not $ elem x [' ', '\'']) $ line1
        in case (cleanLine == reverse cleanLine) of
             True  -> putStrLn "It's a palindrome"
             False -> putStrLn "Nope!"



