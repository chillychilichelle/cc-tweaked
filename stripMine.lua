turtle.refuel()
local starting = turtle.getFuelLevel()
local half = starting/2
local count = 0
while (turtle.getFuelLevel()>half) do
    turtle.dig()
    turtle.up()
    while turtle.detect() do
        turtle.dig()        
    end
    turtle.forward()
    
    turtle.dig()
    while turtle.detect() do
        turtle.dig()        
    end
    turtle.dig()
    turtle.forward()

    count = count + 2
end

for i = count,1,-1
do
    turtle.back()
end