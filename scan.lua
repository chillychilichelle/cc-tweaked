require "turtleUtils"

print("THIS WILL MINE THE ENTIRE SELECTED AREA")
print("PLACE IN THE UPMOST BOTTOM-LEFT CORNER")
print(" ")
print("Name the result blueprint (Don't include \".txt\"): ")
local path = "blueprints/"
local fileName = read()
fileName= fileName..".txt"
print("Select X (Rightwards length): ")
local x =read()
print("Select Y (Upwards length): ")
local y =read()
print("Select Z (Forwards length): ")
local z =read()

print("X:  "..x.." Y:  "..y.." Z:  "..z)
print("Press enter to begin...")
read()

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
                    blockDictionary[data.name]=string.char(current);
                    current = current + 1
                end
                mapData[j][i][k]=blockDictionary[data.name]
                
                turtle.digDown()
            else
                mapData[j][i][k]='.'
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

local file = fs.open(path..fileName,"w")
file.write(x.."\n")
file.write(y.."\n")
file.write(z.."\n")
for i = 1, y, 1 do
    for j = z, 1, -1 do
        for k = 1, x, 1 do
            file.write(mapData[k][i][j])
        end
        file.write("\n")
    end
    file.write("\n")
end

for key, value in pairs(blockDictionary) do
    file.write(value.." - "..key)
    file.write("\n")
end

file.close()