package.path = package.path .. ";../?.lua"
require "utils"

local scanner =peripheral.wrap("right");
local scanRadius = 8;
local result, msg = scanner.scan(scanRadius);
local size =2*scanRadius +1;

if result==nil then
    print("Error: "..msg);
    return;
end

local table ={};

for i = 1, size do
    table[i]={};
    for j = 1, size do
        table[i][j]={};
    end
end

for key, value in pairs(result) do
    local x = value[x];
    local y = value[y];
    local z = value[z];
    local name = value[name];
    table[x][y][z]=name;
end

