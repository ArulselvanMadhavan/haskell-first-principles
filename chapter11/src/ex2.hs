module Ex2 where

data OperatingSystem =
    GnuPlusLinux
    | OpenBSDPlusNeverMindJustBSDStill
    | Mac
    | Windows
    deriving (Eq, Show, Enum)

data Proglang =
    Haskell
    | Agda
    | Idris
    | Purescript
    deriving (Eq, Show, Enum)

data Programmer =
    Programmer {
      os   :: OperatingSystem
    , lang :: Proglang
    } deriving (Eq, Show)

allPossibleProgrammers :: [Programmer]
allPossibleProgrammers =
    [Programmer os pl | os <- enumFrom GnuPlusLinux, pl <- enumFrom Haskell]
