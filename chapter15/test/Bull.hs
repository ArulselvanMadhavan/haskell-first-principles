module Bull where
import           Control.Monad
import           Data.Monoid
import           MonoidTestUtils
import           Test.QuickCheck

data Bull =
    Fools
  | Twoo
  deriving (Eq, Show)

instance Arbitrary Bull where
    arbitrary =
        frequency [ (1, return Fools)
                  , (1, return Twoo) ]

instance Monoid Bull where
    mempty = Fools
    mappend _ _ = Fools

type BullMappend =
    Bull -> Bull -> Bull -> Bool

runTests :: IO ()
runTests = do
  let ma  = monoidAssoc
      mli = monoidLeftIdentity
      mri = monoidRightIdentity
  quickCheck (ma :: BullMappend)
  quickCheck (mli :: Bull -> Bool)
  quickCheck (mri :: Bull -> Bool)

