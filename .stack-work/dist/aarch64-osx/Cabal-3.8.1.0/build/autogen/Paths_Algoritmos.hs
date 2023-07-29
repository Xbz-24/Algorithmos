{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_Algoritmos (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
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

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/xbz/Developer/1/Algoritmos/.stack-work/install/aarch64-osx/1c7f7bccdd74dd444aa6e64c459169e05395e72117b1f01031395e054cebc789/9.4.5/bin"
libdir     = "/Users/xbz/Developer/1/Algoritmos/.stack-work/install/aarch64-osx/1c7f7bccdd74dd444aa6e64c459169e05395e72117b1f01031395e054cebc789/9.4.5/lib/aarch64-osx-ghc-9.4.5/Algoritmos-0.1.0.0-29Vah26RzUx5M408rIqR0K"
dynlibdir  = "/Users/xbz/Developer/1/Algoritmos/.stack-work/install/aarch64-osx/1c7f7bccdd74dd444aa6e64c459169e05395e72117b1f01031395e054cebc789/9.4.5/lib/aarch64-osx-ghc-9.4.5"
datadir    = "/Users/xbz/Developer/1/Algoritmos/.stack-work/install/aarch64-osx/1c7f7bccdd74dd444aa6e64c459169e05395e72117b1f01031395e054cebc789/9.4.5/share/aarch64-osx-ghc-9.4.5/Algoritmos-0.1.0.0"
libexecdir = "/Users/xbz/Developer/1/Algoritmos/.stack-work/install/aarch64-osx/1c7f7bccdd74dd444aa6e64c459169e05395e72117b1f01031395e054cebc789/9.4.5/libexec/aarch64-osx-ghc-9.4.5/Algoritmos-0.1.0.0"
sysconfdir = "/Users/xbz/Developer/1/Algoritmos/.stack-work/install/aarch64-osx/1c7f7bccdd74dd444aa6e64c459169e05395e72117b1f01031395e054cebc789/9.4.5/etc"

getBinDir     = catchIO (getEnv "Algoritmos_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "Algoritmos_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "Algoritmos_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "Algoritmos_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Algoritmos_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Algoritmos_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
