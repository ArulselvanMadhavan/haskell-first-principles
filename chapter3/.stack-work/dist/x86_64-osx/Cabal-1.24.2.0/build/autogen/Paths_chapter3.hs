{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_chapter3 (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/amadhavan1/dev/haskell-projects/haskell-first-principles/chapter3/.stack-work/install/x86_64-osx/lts-9.4/8.0.2/bin"
libdir     = "/Users/amadhavan1/dev/haskell-projects/haskell-first-principles/chapter3/.stack-work/install/x86_64-osx/lts-9.4/8.0.2/lib/x86_64-osx-ghc-8.0.2/chapter3-0.1.0.0-E5Ocv7Gn56u7in44Ux3Dti"
dynlibdir  = "/Users/amadhavan1/dev/haskell-projects/haskell-first-principles/chapter3/.stack-work/install/x86_64-osx/lts-9.4/8.0.2/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/amadhavan1/dev/haskell-projects/haskell-first-principles/chapter3/.stack-work/install/x86_64-osx/lts-9.4/8.0.2/share/x86_64-osx-ghc-8.0.2/chapter3-0.1.0.0"
libexecdir = "/Users/amadhavan1/dev/haskell-projects/haskell-first-principles/chapter3/.stack-work/install/x86_64-osx/lts-9.4/8.0.2/libexec"
sysconfdir = "/Users/amadhavan1/dev/haskell-projects/haskell-first-principles/chapter3/.stack-work/install/x86_64-osx/lts-9.4/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "chapter3_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "chapter3_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "chapter3_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "chapter3_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "chapter3_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "chapter3_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
