package.path = package.path .. ";../?.lua"
require "utils"

local scanner =peripheral.wrap("right");
local x =1;
local cost = scanner.cost(x);
print("It costs "..cost.." fuel to scan with a radius of "..x);
local result, msg = scanner.scan(x);

if result==nil then
    print("Error: "..msg);
else
    local resultStr = "";
    
    for key, value in pairs(result) do
        resultStr=resultStr..value["name"].."\n";
        resultStr=resultStr.." "..value["x"]..","..value["y"]..","..value["z"].."\n";
    end
    writeToFile(resultStr,"geoOutput.txt");
    writeTableToFile(result,"geoOutputFull.txt");
end


--[[
    GEOSCANNER BASICS

    It returns a table that stretches x blocks in every direction
    If you scan with x=2, it will scan all blocks fom -2,-2,-2 to 2,2,2,
    Local position, so the computer will always be at 0,0,0

    Each scan takes fuel, with 8 blocks being the most you can 
        scan for free, as seen below

        x=0-8:  0 fuel
        x=9:    330 fuel
        x=10:   739 fuel

    It returns an array-like table containg nested tables values
    These nested table values represent blocks, containg name, coords,
        and another nested table containing tags. See below for a sample
    
1/
 y/-1
 x/-1
 name/minecraft:mangrove_planks
 z/-1
 tags/
  1/minecraft:block/minecraft:planks
  2/minecraft:block/minecraft:mineable/axe
2/
 y/-1
 x/-1
 name/minecraft:mangrove_planks
 z/0
 tags/
  1/minecraft:block/minecraft:planks
  2/minecraft:block/minecraft:mineable/axe
3/
 y/-1
 x/-1
 name/minecraft:mud
 z/1
 tags/
  1/minecraft:block/minecraft:big_dripleaf_placeable
  2/minecraft:block/minecraft:mineable/shovel
  3/minecraft:block/minecraft:sculk_replaceable_world_gen
  4/minecraft:block/minecraft:snow_layer_can_survive_on
]]
