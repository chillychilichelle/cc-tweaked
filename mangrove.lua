package.path = package.path .. ";../?.lua"
require "turtleUtils";

local scanner =peripheral.wrap("right");
local scanRadius = 8;
local size =2*scanRadius +1;

for i = 1, scanRadius do
    if turtle.detectUp() then
        turtle.digUp()
    end
    turtle.up()
end

local ts = TurtleState()
ts.rotationLock=false;

local result, msg = scanner.scan(scanRadius);

if result==nil then
    print("Error: "..msg);
    return;
end

for key, value in pairs(result) do
    if value["name"] ~= "minecraft:mangrove_log" and value["name"] ~= "minecraft:mangrove_roots" then
        table.remove(result, key)
    end
end

--unneeded table formatting
--[[
local table ={};

for i = -size, size do
    table[i]={};
    for j = -size, size do
        table[i][j]={};
    end
end

for key, value in pairs(result) do
    local x = value["x"];
    local y = value["y"];
    local z = value["z"];
    local name = value["name"];
    table[x][y][z]=name;
end
]]

while #result > 0 do
    local nnInd = #result
    local nnBlock = result[nnInd]
    local nnDist = manhattan3d(ts.coords, {nnBlock["x"], nnBlock["y"], nnBlock["z"]})

    for j = 1, #result, 1 do
        local newBlock = result[j]
        local newDist = manhattan3d(ts.coords, {newBlock["x"], newBlock["y"], newBlock["z"]})
        if (newDist < nnDist) then
            nnInd = j
            nnBlock = newBlock
            nnDist = newDist
        end
        if (nnDist == 1) then
            break
        end
    end
    table.remove(result, nnInd)
    ts.moveToHorizontal({nnBlock["x"], nnBlock["z"]})
    ts.moveToVertical(nnBlock["y"])
end
