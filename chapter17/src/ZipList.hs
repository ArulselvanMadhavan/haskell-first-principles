module ZipList where
import           Control.Applicative

instance Monoid a => Monoid (ZipList a) where
    mempty = pure mempty
    mappend = liftA2 mappend
