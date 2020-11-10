module ShuntingYard where

import Utils
import Error

{-*Algo Shunting Yard*-}

algoSY :: [[Char]] -> [[Char]] -> [[Char]] -> IO ([[Char]])
algoSY [] ret arraySymbole 
        | ((inList "(" arraySymbole) || (inList ")" arraySymbole)) = exitErrorCharRet
        | otherwise = return (ret ++ arraySymbole)

algoSY (symbole:symboles) ret arraySymbole =
    do 
        let isSup operaror = if ((getOperator symbole) <= (getOperator operaror)) then True else False
            in 
                if (isFloat symbole == True)
                    then
                    algoSY symboles (ret ++ [symbole]) arraySymbole
                else if (inList symbole ["+", "-", "*", "/", "^"] == True)
                    then
                    let toRemove = takeWhile isSup arraySymbole in algoSY symboles (ret ++ toRemove) ([symbole] ++ (drop (length toRemove) arraySymbole))
                else if (symbole == "(")
                    then
                    algoSY symboles ret ([symbole] ++ arraySymbole)
                else if (symbole == ")")
                    then
                    let toRemove = (takeWhile ("("/=) arraySymbole) in if (toRemove == arraySymbole) then exitErrorCharRet else algoSY symboles (ret ++ toRemove) (drop ((length toRemove) + 1) arraySymbole)
                else
                    return ret

