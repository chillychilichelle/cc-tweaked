package.path = package.path .. ";../?.lua"
require "turtleUtils";
require "utils";

--for custom targets, uncomment this empty array and comment the real one
--local targets ={}

--[
local targets = {
    "minecraft:coal_ore",
    "minecraft:iron_ore",
    "minecraft:gold_ore",
    "minecraft:diamond_ore",
    "minecraft:emerald_ore",
    "minecraft:copper_ore",
    "minecraft:lapis_ore",
    "minecraft:redstone_ore",
    
    "minecraft:deepslate_coal_ore",
    "minecraft:deepslate_iron_ore",
    "minecraft:deepslate_gold_ore",
    "minecraft:deepslate_diamond_ore",
    "minecraft:deepslate_emerald_ore",
    "minecraft:deepslate_copper_ore",
    "minecraft:deepslate_lapis_ore",
    "minecraft:deepslate_redstone_ore",
}
--]]

--TODO:use a tag system to simplify this, since it's picked up by the geoscanner anyway

local scanner =peripheral.wrap("right");

print("Input scan radius:")
local scanRadius =tonumber(read())

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
    if not isElementInArray(value["name"],targets) then
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