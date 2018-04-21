{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Marshalling where

import           Control.Applicative
import           Data.Aeson
import           Data.ByteString.Lazy (ByteString)
import           Data.Text            (Text)
import qualified Data.Text            as T
import           Text.RawString.QQ

sectionJson :: ByteString
sectionJson = [r|
{ "section": {"host": "wikipedia.org"},
  "whatisit": {"red": "intoothandclaw"}
}
|]

data TestData = TestData {
    section :: Host,
    what    :: Color
    } deriving (Eq, Show)

newtype Host =
  Host String
  deriving (Eq, Show)

data Color
  = Red String
  | Blue String
  | Yellow String
  deriving (Eq, Show)

instance FromJSON TestData where
    parseJSON (Object v) =
        TestData <$> v .: "section" <*> v.: "whatisit"
    parseJSON _ = fail "Expected an object for TestData"

instance FromJSON Host where
    parseJSON (Object v) =
        Host <$> v .: "host"
    parseJSON _ = fail "Expected an object for Host"

instance FromJSON Color where
    parseJSON (Object v) =
        (Red <$> v.: "red")
        <|> (Blue <$> v .: "blue")
        <|> (Yellow <$> v .: "yellow")
    parseJSON _ =
        fail "Expected an object for Color"

