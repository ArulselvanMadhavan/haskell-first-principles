{-# LANGUAGE OverloadedStrings #-}

module HitCounter where
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Class
import           Control.Monad.Trans.Except
import           Control.Monad.Trans.Reader
import           Data.IORef
import qualified Data.Map                   as M
import           Data.Maybe                 (fromMaybe)
import           Data.Text.Lazy             (Text)
import qualified Data.Text.Lazy             as TL
import           System.Environment         (getArgs)
import           Web.Scotty.Internal.Types  (ActionT (..))
import           Web.Scotty.Trans

data Config = Config
  { counts :: IORef (M.Map Text Integer)
  , prefix :: Text
  }

type Scotty = ScottyT Text (ReaderT Config IO)
type Handler = ActionT Text (ReaderT Config IO)

nextValue :: Text -> M.Map Text Integer -> Integer
nextValue k m = (fromMaybe 0 (M.lookup k m)) + 1

bumpBoomp :: Text -> M.Map Text Integer -> (M.Map Text Integer, Integer)
bumpBoomp k m = (M.insert k newValue m, newValue)
  where
    newValue = nextValue k m

getPrefixFromConfig :: ReaderT Config IO Text
getPrefixFromConfig = do
  c <- ask
  return $ prefix c

updateIORef :: Text -> IORef (M.Map Text Integer) -> IO (Integer)
updateIORef k x = do
  m <- readIORef x
  let (mm, i) = bumpBoomp k m
  modifyIORef x (\_ -> mm)
  return i

getCountFromConfig :: Text -> ReaderT Config IO Integer
getCountFromConfig k = ReaderT (\c -> updateIORef k (counts c))

app :: Scotty ()
app =
  get "/:key" $ do
    unprefixed <- (param "key") :: Handler Text
    pp <- lift getPrefixFromConfig
    let key' = mappend pp unprefixed
    newInteger <- lift (getCountFromConfig key')
    html $
      mconcat ["<h1>Success! Count was: ", TL.pack $ show newInteger, "</h1>"]

main :: IO ()
main = do
    [prefixArg] <- getArgs
    counter <- newIORef M.empty
    let config = Config counter (TL.pack prefixArg)
        runR = undefined
    scottyT 3000 runR app
