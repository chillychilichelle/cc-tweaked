turtle.refuel()
local starting = turtle.getFuelLevel()
local half = starting/2
local count = 0
while (turtle.getFuelLevel()>half) do
    while turtle.detect() do
        turtle.dig()        
    end
    turtle.up()
    while turtle.detect() do
        turtle.dig()        
    end
    turtle.forward()
    
    while turtle.detect() do
        turtle.dig()        
    end
    turtle.down()
    while turtle.detect() do
        turtle.dig()        
    end
    turtle.forward()

    count = count + 2
end

for i = count,1,-1
do
    turtle.back()
end