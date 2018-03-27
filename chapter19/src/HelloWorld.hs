{-# LANGUAGE OverloadedStrings #-}
module HelloWorld where
import           Data.Monoid (mconcat)
import           Web.Scotty

main :: IO ()
main =
  scotty 3000 $ do
    get "/:word" $ do
      beam <- param "word"
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
