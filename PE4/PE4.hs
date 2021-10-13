module PE4 where

import Data.Maybe -- up to you if you want to use it or not

-- Generic DictTree definition with two type arguments
data DictTree k v = Node [(k, DictTree k v)] | Leaf v deriving Show

-- Lightweight Char wrapper as a 'safe' Digit type
newtype Digit = Digit Char deriving (Show, Eq, Ord) -- derive equality and comparison too!

-- Type aliases
type DigitTree = DictTree Digit String
type PhoneNumber = [Digit]


---------------------------------------------------------------------------------------------
------------------------- DO NOT CHANGE ABOVE OR FUNCTION SIGNATURES-------------------------
--------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
--------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
---------------------------------------------------------------------------------------------


----------
-- Part I:
-- Some Maybe fun! Basic practice with an existing custom datatype.

-- toDigit: Safely convert a character to a digit
toDigit :: Char -> Maybe Digit
toDigit x | x `elem` ['0','1','2','3','4','5','6','7','8', '9']  = Just (Digit x)
    | otherwise = Nothing

-- toDigits: Safely convert a bunch of characters to a list of digits.
--           Particularly, an empty string should fail.

toDigits :: String -> Maybe PhoneNumber
toDigits s = helper s []

helper "" [] = Nothing
helper "" o = Just o
helper (x:xs) o | Data.Maybe.isNothing (toDigit x) = Nothing
    |otherwise = helper xs (o++[Digit x])

-----------
-- Part II:
-- Some phonebook business.

-- numContacts: Count the number of contacts in the phonebook...
numContacts :: DigitTree -> Int
numContacts (Node x) = counter x 0
numContacts (Leaf v) = 1
counter ((x,Leaf v):xs) r = counter xs (r+1)
counter ((x,Node n):xs) r = counter (xs++ n) r
counter [] r = r
    
-- getContacts: Generate the contacts and their phone numbers in order given a tree. 
getContacts :: DigitTree -> [(PhoneNumber, String)]
getContacts (Node x) = contact x [] []
contact ((x,Leaf v):xs) r o = contact xs r (o++[((r++[x]),v)])
contact ((x,Node n):xs) r o = (contact (n) (r++[x]) o)++ (contact xs r [])
contact [] _ o = o

-- autocomplete: Create an autocomplete list of contacts given a prefix
-- e.g. autocomplete "32" areaCodes -> 
--      [([Digit '2'], "Adana"), ([Digit '6'], "Hatay"), ([Digit '8'], "Osmaniye")]

getDigits (Just x)= x
getDigits Nothing = []

h [] _ = []
h _ [] = []
h pn ((digits,leaf):xs) = (g pn digits leaf) ++ h pn xs  

g (x:xs) (a:as) v= if length xs ==0 && x==a then [(as,v)]
    else if length xs > length as  then []
    else if (x==a) then g xs as v
    else []

autocomplete :: String -> DigitTree -> [(PhoneNumber, String)]
autocomplete s x = h (getDigits (toDigits s)) (getContacts x)



-----------
-- Example Trees
-- Two example trees to play around with, including THE exampleTree from the text. 
-- Feel free to delete these or change their names or whatever!

exampleTree :: DigitTree
exampleTree = Node [
    (Digit '1', Node [
        (Digit '3', Node [
            (Digit '7', Node [
                (Digit '8', Leaf "Jones")])]),
        (Digit '5', Leaf "Steele"),
        (Digit '9', Node [
            (Digit '1', Leaf "Marlow"),
            (Digit '2', Node [
                (Digit '3', Leaf "Stewart")])])]),
    (Digit '3', Leaf "Church"),
    (Digit '7', Node [
        (Digit '2', Leaf "Curry"),
        (Digit '7', Leaf "Hughes")])]

areaCodes :: DigitTree
areaCodes = Node [
    (Digit '3', Node [
        (Digit '1', Node [
            (Digit '2', Leaf "Ankara")]),
        (Digit '2', Node [
            (Digit '2', Leaf "Adana"),
            (Digit '6', Leaf "Hatay"),
            (Digit '8', Leaf "Osmaniye")])]),
    (Digit '4', Node [
        (Digit '6', Node [
            (Digit '6', Leaf "Artvin")])])]

