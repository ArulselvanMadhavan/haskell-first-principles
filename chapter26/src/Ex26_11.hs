{-# LANGUAGE OverloadedStrings #-}
module Ex26_11 where

import           Control.Monad.IO.Class
import           Data.Maybe             (fromMaybe)
import           Data.Text.Lazy         (Text)
import           Web.Scotty

param' :: Parsable a => Text -> ActionM (Maybe a)
param' k = rescue (Just <$> param k) (const (return Nothing))

main :: IO ()
main =
  scotty 3000 $ do
    get "/:word" $ do
      beam' <- (param' "word") :: ActionM (Maybe Text)
      let beam = fromMaybe "" beam'
      i <- param' "num"
      liftIO $ print (i :: Maybe Integer)
      html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
