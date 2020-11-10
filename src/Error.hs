module Error where

import System.Exit

exitError :: IO ()
exitError = exitWith (ExitFailure 84)

exitErrorCharRet :: IO ([[Char]])
exitErrorCharRet = exitWith (ExitFailure 84)

exitErrorDoubleRet :: IO (Double)
exitErrorDoubleRet = exitWith (ExitFailure 84)