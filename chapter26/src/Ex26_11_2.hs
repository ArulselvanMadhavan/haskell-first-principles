{-# LANGUAGE OverloadedStrings #-}

module Ex26_11_2 where

import           Control.Monad.IO.Class
import           Data.Text.Lazy         as TL
import           Web.Scotty

param' :: Parsable a => Text -> ActionM (Either String a)
param' k =
  rescue
    (Right <$> param k)
    (const (return (Left $ "The Key:" ++ show k ++ " was missing!")))


main :: IO ()
main =
  scotty 3000 $ do
    get "/:word" $ do
      beam <- (param' "word") :: ActionM (Either String Text)
      let beam' = either TL.pack id beam
      a <- param' "1"
      let a' = either (const 0) id a
      liftIO $ print (a :: Either String Int)
      liftIO $ print (a' :: Int)
      html $ mconcat ["<h1>Scotty,", beam', " me up!</h1>"]
