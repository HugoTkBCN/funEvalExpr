module CheckArg where

import Utils
import Error

checkArg :: [[Char]] -> Int -> IO ()
checkArg [] counter = exitError
checkArg symboles counter
    | (counter == length symboles) = return () 
    | ((counter == (length symboles) - 1 || counter == 0) && inList currentSymbole ["+", "-", "*", "/", "^"]) = exitError
    | (currentSymbole == ")" || currentSymbole == "(" || isFloat currentSymbole) = checkArg symboles (counter + 1)
    | (inList currentSymbole ["+", "-", "*", "/", "^"]) = if inList (symboles !! (counter - 1)) ["+", "-", "*", "/", "^"] == False 
                                                then 
                                                do
                                                    checkArg symboles (counter + 1)
                                                else 
                                                    exitError
    | otherwise = exitError
        where currentSymbole = symboles !! counter