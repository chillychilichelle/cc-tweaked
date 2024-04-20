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
print("AT THE FLOOR-LEVEL OF YOUR BUILD")
print(" ")
print("Name the result blueprint (Don't include \".txt\"): ")
local path = "blueprints/"
local fileName = read()
fileName= fileName..".txt"


if(fs.exists(path..fileName)) then
    print("Overwriting data...")
    fs.delete(path..fileName)
end

print("Select X (How many blocks from this computer does it go right?): ")
local x_MAX =tonumber(read())
print("Select Y (How many blocks from this computer does it go up, not counting the floor?): ")
local y_MAX =tonumber(read())
print("Select X (How many blocks from this computer does it go forward?): ")
local z_MIN =tonumber(read())

print("X:  "..x_MAX.." Y:  "..y_MAX.." Z:  "..z_MIN)
print("Press enter to begin...")
read()

local scanRadius = math.max(math.max(x_MAX,y_MAX),z_MIN)


local result, msg = scanner.scan(scanRadius);
if result==nil then
    print("Error: "..msg);
    return;
end

local mapData ={};
local blockDictionary ={}

for i = 1, x_MAX do
    mapData[i]={};
    --since it's AT (not below) the lowest point of the build, it should count 0
    for j = 0, y_MAX do
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

    if( x<1 or y<0 or z>-1 or x >x_MAX or y>y_MAX or z<-z_MIN) then
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
file.write(x_MAX.."\n")
file.write(y_MAX.."\n")
file.write(z_MIN.."\n")
file.write("\n")
for i = 0, y_MAX, 1 do
    for j = -1, -z_MIN, -1 do
        for k = 1, x_MAX, 1 do
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
