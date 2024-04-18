package.path = package.path .. ";../?.lua"
require "utils"

local scanner =peripheral.wrap("right");
local x =3;
local cost = scanner.cost(x);
print("It costs "..cost.." fuel to scan with a radius of "..x);
local result, msg = scanner.scan(5);

if result==nil then
    print("Error: "..msg);
else
    printArrayToFile(result,"geoOutput.txt");
end