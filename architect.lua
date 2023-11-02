require "turtleUtils"
require "utils"

function shouldPlaceBlock(currentChar)
    return (currentChar ~= '.' and currentChar ~=' ')
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

for i = 1, z, 1 do
    local mapDataZCnt = 1
    mapData[i]={}
    for j = y, 1, -1 do
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

local currentCoords = {1, 1}


--nearest neighbour algorithm per z-layer
for i = 1, z, 1 do
    local layersPoints = mapData[i]

    --print("Layer has "..#layersPoints.." points")

    while #layersPoints > 0 do
        local nn = layersPoints[1]
        local nnDist = manhattan(currentCoords, nn)
        local nnInd =1

        for j=1, #layersPoints, 1 do
            local newCoords= layersPoints[j]
            local newDist = manhattan(currentCoords, newCoords)
            --print("Checking "..newCoords[1]..", "..newCoords[2])
            if (newDist <nnDist) then
                nn = newCoords
                nnDist = newDist
                nnInd = j
                --print("New nearest neighbour is "..nn[1]..", "..nn[2])
            end
            if(newDist<=1) then break end
        end 

        table.remove(layersPoints,nnInd)

        --print("Moving from "..currentCoords[1]..", "..currentCoords[2].. " to "..nn[1]..", "..nn[2])
        goToCoords(currentCoords,nn)
        currentCoords = nn

        
        if(ifCurrentSlotIsEmpty())then
            goToNextItemSlot()
        end

        if(turtle.detectDown())then
            turtle.digDown()
        end
        turtle.placeDown()        

    end
    turtle.up()
    
end

