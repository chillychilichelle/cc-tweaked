require "turtleUtils"
require "utils"

function shouldPlaceBlock(currentChar)
    return (currentChar ~= '.' and currentChar ~=' ')
end

function restockProcess(ts)
    local leftOff =deepCopyArray(ts.coords)
    local dir =ts.orientation
    printArray(leftOff)

    if dir==1 then
        turtle.turnLeft()
    end

    ts.moveToHorizontal({1,0})
    ts.moveToVertical(1)
    turtle.turnRight()
    turtle.turnRight()
    while turtle.suck() do
       print("Suck...") 
    end
    turtle.turnRight()
    turtle.turnRight()
    ts.moveToVertical(leftOff[2])
    ts.moveToHorizontal(leftOff[1],leftOff[3])
    
    if dir==1 then
        turtle.turnRight()
    end
end


local args  = {...}
local target = args[1]
print("Attempting to build "..target.." ...")

if(not fs.exists(target)) then
    print("The blueprint does not exist...")
    return
end

print("Reading "..target.." ...")
local file = fs.open(target,"r")
local x = tonumber(file.readLine())
local y = tonumber(file.readLine())
local z = tonumber(file.readLine())
print("X:  "..x.." Y:  "..y.." Z:  "..z)

local mapData ={}
local blockCnt=0

for i = 1, y, 1 do
    local mapDataZCnt = 1
    mapData[i]={}
    for j = z, 1, -1 do
        local str = file.readLine()
        for k = 1, #str, 1 do
            local currentChar = str:sub(k,k)
            if(shouldPlaceBlock(currentChar)) then
                mapData[i][mapDataZCnt] = {}
                mapData[i][mapDataZCnt][1]=k
                mapData[i][mapDataZCnt][2]=j
                mapDataZCnt = mapDataZCnt + 1
                blockCnt = blockCnt + 1
            end
        end
    end
    local _ =file.readLine()
end

file.close()

print("This blueprint requires "..blockCnt.." blocks to construct!")

local startingCoords = {1, 1, 1}
local ts = TurtleState(startingCoords,1)


--nearest neighbour algorithm per y-layer
for i = 1, y, 1 do
    local layersPoints = mapData[i]
    --print("Layer has "..#layersPoints.." points")

    while #layersPoints > 0 do
        local nnInd =#layersPoints
        local nn = layersPoints[nnInd]
        local nnDist = manhattan(ts.getXZ(), nn)

        for j=1, #layersPoints, 1 do
            local newCoords= layersPoints[j]
            local newDist = manhattan(ts.getXZ(), newCoords)
            --print("Checking "..newCoords[1]..", "..newCoords[2])
            if (newDist <nnDist) then
                nnInd = j
                nn = newCoords
                nnDist = newDist
                --print("New nearest neighbour is "..nn[1]..", "..nn[2])
            end
            if(nnDist<=1) then break end
        end 

        table.remove(layersPoints,nnInd)

        --print("Moving from "..currentCoords[1]..", "..currentCoords[2].. " to "..nn[1]..", "..nn[2])
        --goToCoords(currentCoords,nn)
        ts.moveToHorizontal(nn)

        
        if(ifCurrentSlotIsEmpty())then
            if(ifInventoryIsEmptyOfBlocks())then
                --return and refill
                restockProcess(ts)
            else 
                nextFullItemSlot()
            end
        end

        if(turtle.detectDown())then
            turtle.digDown()
        end
        turtle.placeDown()        

    end
    ts.moveUp(1)
    
end
