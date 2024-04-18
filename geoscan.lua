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