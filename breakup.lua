
while turtle.detectUp() do
    turtle.digUp()
    turtle.up()
end

while not turtle.detectDown() do
    turtle.down()
end