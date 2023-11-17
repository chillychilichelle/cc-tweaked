
while turtle.detectDown() do
    turtle.digDown()
    turtle.down()
end

while not turtle.detectDown() do
    turtle.down()
end