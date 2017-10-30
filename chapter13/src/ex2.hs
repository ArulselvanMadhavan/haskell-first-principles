import           Control.Monad (forever)

palindrome :: IO()
palindrome = forever $ do
    line1 <- getLine
    case (line1 == reverse line1) of
      True  -> putStrLn "It's a palindrome"
      False -> putStrLn "Nope!"
