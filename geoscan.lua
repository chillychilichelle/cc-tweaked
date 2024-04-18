package.path = package.path .. ";../?.lua"
require "utils"

local x =3;
local cost = cost(x);
print("It costs "..x.." fuel to scan with a radius of x");
local result, msg = localscan(5);

if result==nil then
    print("Error: "..msg);
else
    printArray(result);
end