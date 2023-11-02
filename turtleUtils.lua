function goToNextItemSlot()
    local cur = turtle.getSelectedSlot()
    turtle.select( (cur%16)+1)
end

function ifCurrentSlotIsEmpty()
    return turtle.getItemCount() <=0
end

function TurtleState(coords, orientation)
    local self = {}
    self.x = coords[1]
    self.y = coords[2]

    -- 0 UP
    -- 1 RIGHT
    -- 2 DOWN
    -- 3 LEFT
    self.orientation = orientation

    function self:moveTo(target)
        local x1 = coords[1]
        local y1 = coords[2]
    
        local x2 = target[1]
        local y2 = target[2]
        
        local xDif = x2-x1
        if(xDif > 0) then
            if(orientation~=1) then 
                turtle.turnRight()
                orientation=1
            end
            moveForward(xDif)
        elseif (xDif < 0) then
            if(orientation~=1) then 
                turtle.turnRight()
                orientation=1
            end
            moveBack(-xDif)
        end
        
        
        local yDif = y2-y1
        if(yDif > 0) then
            if(orientation~=0) then 
                turtle.turnLeft()
                orientation=1
            end
            moveForward(yDif)
        elseif (yDif < 0) then
            if(orientation~=0) then 
                turtle.turnLeft()
                orientation=1
            end
            moveBack(-yDif)
        end
        
        coords[1]=target[1]
        coords[2]=target[2]
    end



    return self
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
    local x1 = a[1]
    local y1 = a[2]

    local x2 = b[1]
    local y2 = b[2]
    
    local xDif = x2-x1
    if(xDif > 0) then
        moveRight(xDif)
    elseif (xDif < 0) then
        moveLeft(-xDif)
    end
    
    
    local yDif = y2-y1
    if(yDif > 0) then
        moveForward(yDif)
    elseif (yDif < 0) then
        moveBack(-yDif)
    end
end