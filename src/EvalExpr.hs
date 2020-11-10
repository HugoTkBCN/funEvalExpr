module EvalExpr where

import System.Environment
import Utils
import ShuntingYard
import CheckArg
import Error

{-* rpn = Reverse Polish notation *-}

runCalculation :: [[Char]] -> IO ()
runCalculation arguments = do
    let symboleList = getSymboleList arguments
    checkArg symboleList 0
    rpnExpression <- algoSY symboleList [] []
    if (rpnExpression /= []) then printResult rpnExpression else exitError

evalExpr :: IO ()
evalExpr = do
        arguments <- getArgs
        if (length(arguments) == 1) then
            runCalculation arguments
        else 
            exitError