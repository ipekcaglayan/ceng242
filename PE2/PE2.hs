module PE2 where

---------------------------------------------------------------------------------------------
------------------------- DO NOT CHANGE ABOVE OR FUNCTION SIGNATURES-------------------------
--------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
--------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
---------------------------------------------------------------------------------------------

-- Note: undefined is a value that causes an error when evaluated. Replace it with
-- a viable definition! Name your arguments as you like by changing the holes: _

--------------------------
-- Part I: Time to inf up!

-- naturals: The infinite list of natural numbers. That's it!
naturals :: [Integer]
naturals = 0 : map (+1) naturals

-- interleave: Interleave two lists, cutting off on the shorter list.
interleave :: [a] -> [a] -> [a]
interleave [] _ = []
interleave _ [] = []
interleave (x:xs) (y:ys) = [x,y] ++ interleave xs ys

-- integers: The infinite list of integers. Ordered as [0, -1, 1, -2, 2, -3, 3, -4, 4...].
integers :: [Integer]
integers =  drop 1 (interleave (map(*(-1)) naturals) naturals)

--------------------------------
-- Part II: SJSON Prettification

-- splitOn: Split string on first occurence of character.
helper _ [] w = (w, "")
helper d (c:s) w = if  c==d then (w,s) else helper d s (w++[c])
splitOn :: Char -> String -> (String, String)
splitOn d s = helper d s []



helperToken (c:s)
    | c == '{' || c == ':' || c == ',' || c == '}' = [[c]] ++ helperToken s
    | c == ' ' || c == '\n' || c == '\t' = helperToken s
    | c == '\'' = [first split]++(helperToken (second split))  
    | otherwise = []
    where  split = (splitOn '\'' s)
helperToken _ = []

first (s1,s2) = s1
second (s1,s2) = s2
-- tokenizeS: Transform an SJSON string into a list of tokens.
tokenizeS :: String -> [String]
tokenizeS string = helperToken  string

-- prettifyS: Prettify SJSON, better tokenize first!

indentSpace n = if n>0 then "    "++ (indentSpace (n-1)) else ""
new string indent = (indentSpace indent)++  string

prettify (e:l) indent r indentRequired
    | e== "{" = if indentRequired==1 then prettify l (indent+1) (r++ new "{\n" indent)  1 else prettify l (indent+1) (r++ "{\n" ) 1
    | e== ":" = if indentRequired==1 then prettify l (indent) (r++ new ": " indent ) 0 else prettify l (indent) (r++": ") 0
    | e== "," = if indentRequired==1 then prettify l (indent) (r++ new ",\n" indent ) 1 else prettify l (indent) (r++",\n") 1
    | e== "}" =if indentRequired==1 then prettify l (indent-1) (r++ new "\n}" (indent-1)) 1 else prettify l (indent-1) (r++"\n}") 1
    |otherwise = if indentRequired==1 then prettify l indent (r++ new ("\'"++e ++"\'") indent ) 0 
        else prettify l (indent) (r++  ("\'"++e ++"\'")) 0 
    
prettify [] _ r _ = r

prettifyS :: String -> String
prettifyS string = prettify ( tokenizeS string ) 0 "" 0

-- Good luck to you, friend and colleague!

