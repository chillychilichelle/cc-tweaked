require "turtleUtils"
require "utils"
require "numpy"

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

for i = 1, z, 1 do
    local mapDataZCnt = 1
    mapData[i]={}
    for j = y, 1, -1 do
        local str = file.readLine()
        for k = 1, #str, 1 do
            local currentChar = str:sub(k,k)
            if(shouldPlaceBlock(currentChar)) then
                mapData[mapDataZCnt][1]=k
                mapData[mapDataZCnt][2]=j
                mapDataZCnt = mapDataZCnt + 1
            end
        end
    end
    local _ =file.readLine()
end

file.close()


local currentCoords = {1, 1}

-- for each z layer
for i = 1, z, 1 do
    local currentPoints = mapData[i]

    while #currentPoints > 0 do
        local nn = currentPoints[1]
        local nnDist = manhattan(currentCoords, nn)

        for j=1, #currentPoints, 1 do
            local newCoords= currentPoints[j]

            local newDist = manhattan(currentCoords, newCoords)
            if (newDist <nnDist) then
                nn = newCoords
                nnDist = newDist
            end
            if(newDist==1) then break end
        end 

        table.remove(currentPoints,j)

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



function shouldPlaceBlock(currentChar)
    return (currentChar ~= '.' and currentChar ~=' ')
end