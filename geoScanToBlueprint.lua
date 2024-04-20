package.path = package.path .. ";../?.lua"
require "turtleUtils";
require "utils";


print("PLACE IN THE UPMOST BOTTOM-LEFT CORNER")
print("FACE TOWARDS NORTH/-Z")
print(" ")
print("Name the result blueprint (Don't include \".txt\"): ")
local path = "blueprints/"
local fileName = read()
fileName= fileName..".txt"

if(fs.exists(path..fileName)) then
    print("Overwriting data...")
    fs.delete(path..fileName)
end

print("Select largest axis length/scan radius: ")
local scanRadius =read()


local scanner =peripheral.wrap("right");
local size =2*scanRadius +1;

local result, msg = scanner.scan(scanRadius);

if result==nil then
    print("Error: "..msg);
    return;
end


local mapData ={};
local blockDictionary ={}

--change this to only be scanradius
for i = -size, size do
    mapData[i]={};
    for j = -size, size do
        mapData[i][j]={};
    end
end

local current=49;

for key, value in pairs(result) do
    local x = value["x"];
    local y = value["y"];
    local z = value["z"];
    local name = value["name"];

    if(blockDictionary[name]==nil)then
        blockDictionary[name]=string.char(current);
        current = current + 1
    end
    mapData[x][y][z]=blockDictionary[name]

end

local file = fs.open(path..fileName,"w")
file.write(size.."\n")
file.write(size.."\n")
file.write(size.."\n")
file.write("\n")
for i = 1, y, 1 do
    for j = z, 1, -1 do
        for k = 1, x, 1 do
            file.write(mapData[k][i][j])
        end
        file.write("\n")
    end
    file.write("\n")
end

file.write("\n")
file.write("{\n")
for key, value in pairs(blockDictionary) do
    file.write(" \""..value.."\": \""..key.."\"\n")
end
file.write("}\n")

file.close()