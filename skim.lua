package.path = package.path .. ";../?.lua"
require "turtleUtils"

if( not isCurrentSlotOfType("minecraft:bucket")) then
    print("Place an empty bucket in the selected slot.");
    return;
end

local count =0;
local oriLevel=turtle.getFuelLevel();

while turtle.getFuelLevel() < turtle.getFuelLimit() do
    local s=turtle.forward();
    if s==false then break end;
    count=count+1;
    s=turtle.placeDown();
    if s==false then break end;
    turtle.refuel();
end

for i = 1, count do
    turtle.back();
end

--for safety
for i = 1, 3 do
    turtle.back();
end

print("Original fuel level: "..oriLevel);
print("Current fuel level:  "..turtle.getFuelLevel());
print("Maximum fuel level:  "..turtle.getFuelLimit());