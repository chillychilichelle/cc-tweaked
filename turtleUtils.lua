function goToNextItemSlot()
    local cur = turtle.getSelectedSlot()
    turtle.select( (cur%16)+1)
end

function ifCurrentSlotIsEmpty()
    return turtle.getItemCount() <=0
end

function moveForward(x)
    for i = 1, x, 1 do
        turtle.forward()
    end
end

function moveLeft(x)
    turtle.turnLeft()
    moveForward(x)
    turtle.turnRight()
end

function moveRight(x)
    turtle.turnRight()
    moveForward(x)
    turtle.turnLeft()
end

function moveBack(x)
    for i = 1, x, 1 do
        turtle.back()
    end
end

function goToCoords(a,b)
    x1 = a[1]
    y1 = a[2]

    x2 = b[1]
    y2 = b[2]
    
    xDif = x2-x1
    if(xDif > 0) then
        moveRight(xDif)
    elseif (xDif < 0) then
        moveLeft(-xDif)
    end
    
    
    yDif = y2-y1
    if(yDif > 0) then
        moveForward(yDif)
    elseif (xDif < 0) then
        moveBack(-yDif)
    end
end