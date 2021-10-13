module PE1 where

import Text.Printf


-- This function takes a Double and rounds it to 2 decimal places as requested in the PE --
getRounded :: Double -> Double
getRounded x = read s :: Double
               where s = printf "%.2f" x

-------------------------------------------------------------------------------------------
----------------------- DO NOT CHANGE ABOVE OR FUNCTION SIGNATURES-------------------------
------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
-------------------------------------------------------------------------------------------

convertTLHelper :: Double -> String -> Double	
convertTLHelper x "USD" = getRounded (x/8.18)
convertTLHelper x "EUR" = getRounded (x/9.62)
convertTLHelper x "BTC" = getRounded (x/473497.31)

convertTL :: Double -> String -> Double
convertTL money currency = convertTLHelper money currency

-------------------------------------------------------------------------------------------

countOnWatchHelper :: [String] -> String -> Int -> Int
countOnWatchHelper [] employee days= 0
countOnWatchHelper (sch:schedule) employee 0=0
countOnWatchHelper (sch:schedule) employee days = if sch==employee then (1+ (countOnWatchHelper schedule employee (days-1))) else (countOnWatchHelper schedule employee (days-1))
countOnWatch :: [String] -> String -> Int -> Int
countOnWatch schedule employee days = countOnWatchHelper schedule employee days

-------------------------------------------------------------------------------------------
digitCalc::Int->Int
digitCalc x = 
    if (x `mod` 3)==0 then (x-1) `mod` 10
    else if (x `mod` 4)==0 then (x*2) `mod` 10
    else if (x `mod` 5)==0 then (x+3) `mod` 10
    else (x+4) `mod` 10


encryptHelper::Int->Int->Int
encryptHelper 0 digit = 0 
encryptHelper value digit = (digitCalc (value `mod` 10) )*digit + encryptHelper ( value `div` 10) (10*digit)
encrypt :: Int -> Int
encrypt x = encryptHelper x 1

-------------------------------------------------------------------------------------------

interestCalc::(Double, Int)->[Double]
interestCalc (money,years) = 
    if money >= 10000 && years >=2 then [getRounded (money*((1+(0.115/12))^(12*years)))]
    else if money >= 10000 && years <2 then [getRounded (money*((1+(0.105/12))^(12*years)))]
    else if money < 10000 && years >=2 then [getRounded (money*((1+(0.095/12))^(12*years)))]
    else [getRounded( money*((1+(0.09/12))^(12*years)))]
compoundInterestsHelper :: [(Double, Int)] -> [Double]
compoundInterestsHelper [] = []
compoundInterestsHelper ((p1,p2):l) = (interestCalc (p1,p2)) ++ compoundInterestsHelper l
compoundInterests :: [(Double, Int)] -> [Double]
compoundInterests investments = compoundInterestsHelper investments
