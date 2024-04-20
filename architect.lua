package.path = package.path .. ";../?.lua"
require "turtleUtils"
require "utils"

--TODO: make it destroy obstacles, should probably finish turtleState reworks first

function shouldPlaceBlock(currentChar)
    return (currentChar ~= '.' and currentChar ~=' ')
end

function restockProcess(ts)
    print("Restocking...")
    local leftOff =deepCopyTable(ts.coords)

    ts.moveToHorizontal({0,leftOff[3]})
    ts.moveToVertical(0)
    ts.moveToHorizontal({0,0})
    while turtle.suckUp() do
       print("Suck...") 
    end
    ts.moveToHorizontal({0,leftOff[3]})
    ts.moveToVertical(leftOff[2])
    ts.moveToHorizontal({leftOff[1],leftOff[3]})
    
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

--put readline here for gap
file.readLine()

local mapData ={}
local blockCnt=0
local blockDictionary ={}
local usedBlocks ={}

for i = 1, y, 1 do
    local mapDataZCnt = 1
    mapData[i]={}
    for j = z, 1, -1 do
        local str = file.readLine()
        for k = 1, #str, 1 do
            local currentChar = str:sub(k,k)
            if shouldPlaceBlock(currentChar) and blockDictionary[currentChar]==nil then
                blockDictionary[currentChar]="";
                table.insert(usedBlocks,currentChar)
            end
            if(shouldPlaceBlock(currentChar)) then
                mapData[i][mapDataZCnt] = {}
                mapData[i][mapDataZCnt][1]=k
                mapData[i][mapDataZCnt][2]=j
                mapData[i][mapDataZCnt]["char"]=currentChar
                mapDataZCnt = mapDataZCnt + 1
                blockCnt = blockCnt + 1
            end
        end
    end
    local _ =file.readLine()
end

file.close()

print("This blueprint requires "..blockCnt.." block(s) to construct!")
print("Contains "..#usedBlocks.." distinct block(s).")
turtle.select(1)
for key, value in pairs(usedBlocks) do
    print(" ")
    print(key..") Block "..value..": ")
    print("Please insert block into selected slot then press enter...")
        print("(Leave the slot blank if you want to use any block)")
    read()
    local chosenItem = turtle.getItemDetail()
    if(chosenItem==nil) then
        blockDictionary[value]=nil
    else
        blockDictionary[value]=chosenItem.name
    end
    nextItemSlot()
end

for key, value in pairs(blockDictionary) do
    print(key.." - "..value)
end

--starting coords are offset by 1,1
turtle.forward()
turtle.turnRight()
turtle.forward()
turtle.turnLeft()
--x and z are off by 1
local startingCoords = {1, 0, 1}
local ts = TurtleState(startingCoords,0)
ts.rotationLock = true

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
            local newDist = manhattan(ts.getXZ(), {newCoords[1],newCoords[2]} )
            --print("Checking "..newCoords[1]..", "..newCoords[2])
            if (newDist <nnDist) then
                nnInd = j
                nn = newCoords
                nnDist = newDist
                --print("New nearest neighbour is "..nn[1]..", "..nn[2])
            end

            if(nnDist==0) then break end
        end 
        table.remove(layersPoints,nnInd)
        
        local nnBlockType = blockDictionary[nn.char];
        if(nnBlockType ~=nil and  not isCurrentSlotOfType(nnBlockType) and not nextItemSlotOfType(nnBlockType))then
            --TODO: these restockProcess calls have a corner case issue
            --if they go to restock, but the restock inventory is empty
            --but they have a non-matching block in their inventory,
            --they will place down the non-matching block when they return
            --small issue bc it only happens when inventory is empty,
            --which should ideally never happen.
            --this issue is a subissue where running out of inventory
            --skips a block being placed and never fills it

            --issue doesnt happent if nnblocktype is nil because we dont care
            --if the placed block doesn't match
            restockProcess(ts)
            
            --forces a switch to the correct block type after restock
            nextItemSlotOfType(nnBlockType)

        elseif nnBlockType ==nil then
            if(isCurrentSlotEmpty())then
                if(isInventoryEmpty())then
                    --return and refill
                    restockProcess(ts)
                else 
                    nextFullItemSlot()
                end
            end
        end

        ts.moveToHorizontal({nn[1],nn[2]})
        if(turtle.detectDown())then
            turtle.digDown()
        end
        turtle.placeDown()        

    end
    ts.moveUp(1)
    
end

--return to origin
ts.moveToHorizontal({0,ts.coords[3]})
ts.moveToVertical(0)
ts.moveToHorizontal({0,0})