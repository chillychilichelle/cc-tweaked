turtle.refuel()
local starting = turtle.getFuelLevel()
local half = starting/2
local count = 0
while (turtle.detectDown() and turtle.getFuelLevel()>half) do
    turtle.dig()
    turtle.digDown()
    turtle.down()
    turtle.dig()
    turtle.forward()
    turtle.turnRight()
    count = count + 1
end

for i = count,1,-1
do
    turtle.turnLeft()
    turtle.back()
    turtle.up()
end