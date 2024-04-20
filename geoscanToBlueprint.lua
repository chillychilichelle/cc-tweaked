package.path = package.path .. ";../?.lua"
require "turtleUtils";
require "utils";


local scanner =peripheral.wrap("right");
if scanner==nil then
    print("A GEOSCANNER MUST BE EQUIPPED ON THE RIGHT SIDE")
    return;
end

print("PLACE IN THE BOTTOM-LEFT CORNER")
print("(RELATIVE TO NORTH, NOT THE BUILD)")
print("AT THE LOWEST POINT OF YOUR BUILD")
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
local scanRadius = tonumber(read())


local result, msg = scanner.scan(scanRadius);
if result==nil then
    print("Error: "..msg);
    return;
end

local mapData ={};
local blockDictionary ={}

for i = 1, scanRadius do
    mapData[i]={};
    --since it's AT (not below) the lowest point of the build, it should count 0
    for j = 0, scanRadius do
        mapData[i][j]={};
    end
end

local originalASCII=65;
local currentASCII=originalASCII;

for _, value in pairs(result) do
    local x = value["x"];
    local y = value["y"];
    local z = value["z"];
    local name = value["name"];

    if( x<1 or y<0 or z>-1) then
        goto continue
    end

    if(blockDictionary[name]==nil)then
        blockDictionary[name]=string.char(currentASCII);
        currentASCII = currentASCII + 1
    end
    mapData[x][y][z]=blockDictionary[name]
    ::continue::
end

local file = fs.open(path..fileName,"w")
file.write(scanRadius.."\n")
file.write(scanRadius.."\n")
file.write(scanRadius.."\n")
file.write("\n")
for i = 0, scanRadius, 1 do
    for j = -1, -scanRadius, -1 do
        for k = 1, scanRadius, 1 do
            if(mapData[k][i][j]~=nil)then
                file.write(mapData[k][i][j])
            else
                file.write(" ");
            end
        end
        file.write("\n")
    end
    file.write("\n")
end

--if any block has been detected
if currentASCII ~= originalASCII then
    local c = 1;
    local cFin = currentASCII-originalASCII;
    file.write("\n")
    file.write("{\n")
    for key, value in pairs(blockDictionary) do
        if c<cFin then
            file.write(" \""..value.."\": \""..key.."\",\n")
        else
            file.write(" \""..value.."\": \""..key.."\"\n")
        end
        c=c+1;
    end
end
file.write("}\n")


file.close()
