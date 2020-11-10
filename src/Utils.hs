module Utils where

import Text.Read
import Data.List
import Error
import Text.Printf

getOperator :: [Char] -> Int
getOperator op 
            | (op == "+") = 2
            | (op == "-") = 2
            | (op == "*") = 3
            | (op == "/") = 3
            | (op == "^") = 4
            | otherwise = 0

isFloat :: [Char] -> Bool
isFloat num = 
    do
        let response = readMaybe num :: Maybe Double
        if (num == ".")
            then
                True
        else if (response == Nothing)
            then
            False
        else
            True

inList :: [Char] -> [[Char]] -> Bool
inList _ [] = False
inList c (x:xs) = 
    do
        if (c == x)
        then
            True
        else 
            inList c xs

buildNumber :: [[Char]] -> [[Char]] -> [[Char]]
buildNumber [] destList = destList
buildNumber (x:xs) destList =
    do
        let response = takeWhile isFloat ([x] ++ xs)
        if ((isFloat x /= False))
        then
            buildNumber (drop (length response) ([x] ++ xs)) (destList ++ [intercalate "" response])
        else
            buildNumber xs (destList ++ [x])

getNegative :: [[Char]] -> [[Char]] -> Int -> [[Char]]
getNegative symboles ret counter =
    do
    let currentSymbole = symboles !! counter
    if (counter == 0 && currentSymbole == "-")
        then
        let firstNb = currentSymbole ++ (symboles !! 1) in getNegative symboles (ret ++ [firstNb]) (counter + 2)
    else if (counter == length symboles)
        then
        ret
    else if (currentSymbole == "-" && counter /= (length symboles) - 1)
        then
        if (inList (symboles !! (counter - 1)) ["+", "-", "*", "/", "^", "(", ")"] && isFloat (symboles !! (counter + 1)))
            then 
            let nb = currentSymbole ++ (symboles !! (counter + 1)) in getNegative symboles (ret ++ [nb]) (counter + 2)
        else 
            getNegative symboles (ret ++ [currentSymbole]) (counter + 1)
    else
        getNegative symboles (ret ++ [currentSymbole]) (counter + 1)

calcule :: Double -> Double -> [Char] -> IO (Double)
calcule nbr1 nbr2 op
                | (op == "^") = return (nbr1 ** nbr2)
                | (op == "-") = return (nbr1 - nbr2)
                | (op == "+") = return(nbr1 + nbr2)
                | (op == "*") = return (nbr1 * nbr2)
                | (op == "/") = if (nbr2 /= 0) 
                                then 
                                    return (nbr1 / nbr2)
                                else
                                    exitErrorDoubleRet

evaluateRpn :: [[Char]] -> [Double] -> IO (Double)
evaluateRpn [] ret = return (ret !! 0)
evaluateRpn (symbole:symboles) ret =
    do
        let lenRet = length ret
        if (isFloat symbole == True)
            then
            evaluateRpn symboles (ret ++ [(read symbole :: Double)])
        else if (inList symbole ["+", "-", "*", "/", "^"] == True && length ret >= 2)
            then
            do
            tmpResult <- calcule (ret !! (lenRet - 2)) (ret !! (lenRet - 1)) symbole
            evaluateRpn symboles ((take (lenRet - 2) ret) ++ [tmpResult])
        else
            exitErrorDoubleRet

printResult :: [[Char]] -> IO ()
printResult rpnExpression = do
    result <- evaluateRpn rpnExpression []
    printf "%.2f\n" (result)

getSymboleList :: [[Char]] -> [[Char]]
getSymboleList arguments = do
    let expression = (arguments !! 0)
        tmp = buildNumber (words $ intersperse ' ' expression) []
        symboleList = getNegative tmp [] 0
    symboleList