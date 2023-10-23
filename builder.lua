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
    mapData[i]={}
    for j = 1, y, 1 do
        local str = file.readLine()
        mapData[i][j] = str;
    end
    local _ =file.readLine()
end

file.close()
for i = 1, z, 1 do
    for j = 1, y, 1 do
        print(mapData[i][j])
        
    end
    
end

for i = z, 1, -1 do
    turtle.up()
    for j = x, 1, -1 do
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
        for k = y, 1, -1 do
            if(mapData[i][j]:sub(k,k) ~= '.')then
                turtle.placeDown()                
            end
            turtle.forward()
        end
        for k = y, 1, -1 do
            turtle.back()
        end
        
    end
    turtle.turnLeft()
    for j = x, 1, -1 do
        turtle.forward()
        
    end
    turtle.turnRight()
    
end