package.path = package.path .. ";../?.lua"
require "turtleUtils"

if( not isCurrentSlotOfType("minecraft:bucket")) then
    print("Place an empty bucket in the selected slot.");
    return;
end

local count =0;

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