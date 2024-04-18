package.path = package.path .. ";../?.lua"
require "turtleUtils"


function checkFloor()
    if not turtle.detectDown() then
        nextItemSlotOfType("minecraft:cobblestone")
        turtle.placeDown()
    end
end


turtle.refuel()
local starting = turtle.getFuelLevel()
local half = starting/2
local count = 0
local bedrock = false
while (turtle.detectDown() and turtle.getFuelLevel()>half) do
    turtle.dig()
    if not turtle.digDown() then
        break;
    end
    
    turtle.down()
    checkFloor()
    turtle.dig()
    turtle.forward()
    checkFloor()
    count = count+1
end

for i = count,1,-1
do
    turtle.back()
    turtle.up()
end

