module Ex26_14_1 where
import           Control.Monad.Trans.Reader
import           Data.Functor.Identity


rDec :: Num a => Reader a a
rDec = ReaderT (\r -> Identity $ (r - 1))
