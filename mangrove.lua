package.path = package.path .. ";../?.lua"
require "turtleUtils";
require "utils";

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

for i = #result, 1, -1 do
    local value = result[i]
    if value["name"] ~= "minecraft:mangrove_log" and value["name"] ~= "minecraft:mangrove_roots" then
        table.remove(result, i)
    end
end

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

ts.moveToHorizontal({0,0})
ts.moveToVertical(-scanRadius)