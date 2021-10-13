module PE3 where

data Cell = SpaceCraft Int | Sand | Rock Int | Pit deriving (Eq, Read, Show)

type Grid = [[Cell]]
type Coordinate = (Int, Int)

data Move = North | East | South | West | PickUp | PutDown deriving (Eq, Read, Show)

data Robot = Robot { name :: String,
                     location :: Coordinate,
                     capacity :: Int,
                     energy :: Int,
                     storage :: Int } deriving (Read, Show)

-------------------------------------------------------------------------------------------
--------------------------------- DO NOT CHANGE ABOVE -------------------------------------
------------- DUMMY IMPLEMENTATIONS ARE GIVEN TO PROVIDE A COMPILABLE TEMPLATE ------------
------------------- REPLACE THEM WITH YOUR COMPILABLE IMPLEMENTATIONS ---------------------
-------------------------------------------------------------------------------------------
-------------------------------------- PART I ---------------------------------------------

isInGrid :: Grid -> Coordinate -> Bool
lengthOfGrid (a:b) = 1+ lengthOfGrid b
lengthOfGrid [] = 0

lengthOfCell (a:b) = 1+ lengthOfCell b
lengthOfCell [] = 0

isInGrid (c:g) (a,b) = if a < 0  || b < 0 then False 
    else if (lengthOfCell c) <= a then False
    else if (lengthOfGrid g +1) <= b then False
    else True

-------------------------------------------------------------------------------------------

totalCount :: Grid -> Int
checkForCell (Rock a)= a
checkForCell _ = 0
cellList (a:b) = checkForCell a + cellList b
cellList [] = 0

totalCount [] = 0
totalCount (a:b) = cellList a + totalCount b 

-------------------------------------------------------------------------------------------
isPit (Pit) x y =[(x,y)]
isPit _ _ _ = []
helper ((c:cr):g) x y xMax yMax = if (y+1 < yMax && cr/=[]) then (isPit c x y) ++ (helper (g++[cr]) x (y+1) xMax yMax)
    else if (y+1 < yMax && cr==[]) then (isPit c x y) ++ (helper g x (y+1) xMax yMax)
    else if (y+1>=yMax && cr/=[]) then  (isPit c x y) ++ (helper (g++[cr]) (x+1) 0 xMax yMax)
    else if (y+1>=yMax && cr==[]) then  (isPit c x y) ++ (helper g (x+1) 0 xMax yMax)
    else []
helper _ _ _ _ _ =[]


coordinatesOfPits :: Grid -> [Coordinate]
coordinatesOfPits (c:grid) = helper ([c]++grid) 0 0 (lengthOfCell c) (1+ lengthOfGrid grid) 

-------------------------------------------------------------------------------------------

cordInPits (p:pr) cord = if p==cord then True else cordInPits pr cord
cordInPits [] cord =False

movePossible grid robot cord reqE = if ((isInGrid grid cord) && ((cordInPits (coordinatesOfPits grid) cord))==False) then True
    else False


robotX (x,y) = x
robotY (x,y) = y

tracePath :: Grid -> Robot -> [Move] -> [Coordinate]
tracePath _ _ [] =[] 
tracePath grid robot (m:moves) | m==West = if ((movePossible grid robot (rX-1,rY) 1) && energy(robot)>=1) then   [(rX-1,rY)] ++ (tracePath grid robot{location=(rX-1,rY), energy= (max 0 (energy(robot)-1))} moves) else [(rX,rY)] ++ (tracePath grid robot{ energy= (max 0 (energy(robot)-1))} moves)
                               | m==East = if ((movePossible grid robot (rX+1,rY) 1)&& energy(robot)>=1) then  [(rX+1,rY)] ++ (tracePath grid robot{location=(rX+1,rY), energy= (max 0 (energy(robot)-1))} moves) else [(rX,rY)] ++ (tracePath grid robot{ energy= (max 0 (energy(robot)-1))} moves)
                               | m==North = if ((movePossible grid robot (rX,rY-1) 1)&& energy(robot)>=1) then  [(rX,rY-1)] ++ (tracePath grid robot{location=(rX,rY-1), energy= (max 0 (energy(robot)-1))} moves) else [(rX,rY)] ++ (tracePath grid robot{ energy= (max 0 (energy(robot)-1))} moves)
                               | m== South = if ((movePossible grid robot (rX,rY+1) 1)&& energy(robot)>=1) then  [(rX,rY+1)] ++ (tracePath grid robot{location=(rX,rY+1), energy= (max 0 (energy(robot)-1))} moves) else [(rX,rY)] ++ (tracePath grid robot{ energy= (max 0 (energy(robot)-1))} moves)
                               | m==PickUp = [(rX,rY)] ++ (tracePath grid robot{ energy= (max 0 (energy(robot)-5))} moves)
                               | m==PutDown = [(rX,rY)] ++ (tracePath grid robot{ energy= (max 0 (energy(robot)-3))} moves)
                               |otherwise = []
                               where 
                                   rX =robotX (location(robot))
                                   rY =robotY (location(robot))
                                

------------------------------------- PART II ----------------------------------------------

isSC (SpaceCraft _) x y = [(x,y)]
isSC _ _ _ = []
helperSC ((c:cr):g) x y xMax yMax = if (y+1 < yMax && cr/=[]) then (isSC c x y) ++ (helperSC (g++[cr]) x (y+1) xMax yMax)
    else if (y+1 < yMax && cr==[]) then (isSC c x y) ++ (helperSC g x (y+1) xMax yMax)
    else if (y+1>=yMax && cr/=[]) then  (isSC c x y) ++ (helperSC (g++[cr]) (x+1) 0 xMax yMax)
    else if (y+1>=yMax && cr==[]) then  (isSC c x y) ++ (helperSC g (x+1) 0 xMax yMax)
    else []
helperSC _ _ _ _ _ =[]
getSC (c:grid) = getCordSC (helperSC ([c]++grid) 0 0 (lengthOfCell c) (1+ lengthOfGrid grid))
getCordSC (c:cr) = c
getX (x,y)=x
getY (x,y)=y
newEnergy e rx ry sx sy = min 100 (e+(max 0 (100-20*(abs(rx-sx)+ abs(ry-sy)))))
robotArr cordSC (robot:robots) = [robot{energy= newEnergy (energy(robot)) (getX (location(robot))) (getY (location(robot))) (getX cordSC) (getY cordSC)}] ++ (robotArr cordSC robots) 
robotArr _ [] = []
energiseRobots :: Grid -> [Robot] -> [Robot]
energiseRobots grid robots = robotArr (getSC grid) robots

-------------------------------------------------------------------------------------------

applyMoves :: Grid -> Robot -> [Move] -> (Grid, Robot)
applyMoves grid robot moves = (grid, robot)
