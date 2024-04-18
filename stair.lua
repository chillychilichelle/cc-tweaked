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
while (turtle.getFuelLevel()>half) do
    turtle.dig()
    local success, msg = turtle.digDown()
    if not success and msg == "Cannot break unbreakable block" then
        print(msg);
        break;
    end
    
    turtle.down()
    checkFloor()
    turtle.dig()
    turtle.forward()
    count = count+1
end

for i = count,1,-1
do
    turtle.back()
    turtle.up()
end

