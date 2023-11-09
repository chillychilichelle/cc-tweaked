require "turtleUtils"

print("THIS WILL MINE THE ENTIRE SELECTED AREA")
print("PLACE IN THE UPMOST BOTTOM-LEFT CORNER")
print(" ")
print("Select X (Rightwards length): ")
local x =read()
print("Select Y (Upwards length): ")
local y =read()
print("Select Z (Forwards length): ")
local z =read()

print("X:  "..x.." Y:  "..y.." Z:  "..z)

local mapData ={}
local blockDictionary ={}
for i = 1, x, 1 do
    mapData[i]={}
    for j = 1, y, 1 do
        mapData[i][j] = {};
    end
end

local current = 49

for i = y, 1, -1 do
    for j = 1, x, 1 do
        for k = 1, z, 1 do
            local success, data = turtle.inspectDown()
            if(success)then
                if(blockDictionary[data.name]==nil)then
                    blockDictionary[data.name]=current;
                    current = current + 1
                end
                mapData[j][i][k]=string.char(blockDictionary[data.name])
                
                turtle.digDown()
            else
                mapData[i][j][k]=' '
            end
            
            turtle.forward()
        end
        for k = 1, z, 1 do
            turtle.back()
        end
        
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        
    end
    turtle.turnLeft()
    for j = 1, x, 1 do
        turtle.forward()
    end
    turtle.turnRight()
    turtle.down()
    
end

for i = 1, y, 1 do
    for j = z, 1, -1 do
        for k = 1, x, 1 do
            io.write(mapData[k][i][j])
        end
        print(" ")
    end
    print(" ")
end