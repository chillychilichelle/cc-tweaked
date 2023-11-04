
function TurtleState(coords, orientation)
    local self = {}
    self.coords = {}
    self.coords[1] = coords[1]
    self.coords[2] = coords[2]
    self.coords[3] = coords[3]

    self.destroyPerms = true

    -- 0 UP
    -- 1 RIGHT
    -- 2 DOWN
    -- 3 LEFT
    self.orientation = orientation

    --TODO: assumes will never be blocked
    function self.moveToHorizontal(target)
        local x1 = self.coords[1]
        local z1 = self.coords[3]
    
        local x2 = target[1]
        local z2 = target[2]
        
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
        
        
        local yDif = z2-z1
        if(yDif > 0) then
            if(orientation~=0) then 
                turtle.turnLeft()
                orientation=0
            end
            moveForward(yDif)
        elseif (yDif < 0) then
            if(orientation~=0) then 
                turtle.turnLeft()
                orientation=0
            end
            moveBack(-yDif)
        end

        self.coords[1]=target[1]
        self.coords[3]=target[2]
    end

    function self.moveUp(x)
        for i = 1, x, 1 do
            if turtle.up() then
                self.coords[2] = self.coords[2] + 1
            end
        end
    end

    function self.moveDown(x)
        for i = 1, x, 1 do
            if turtle.down() then
                self.coords[2] = self.coords[2] - 1
            end
        end
    end

    function self.getXZ()
        local x = self.coords[1]
        local z = self.coords[3]
        return {x,z}
    end

    return self
end


function moveForward(x)
    for i = 1, x, 1 do
        turtle.forward()
    end
end
function moveBack(x)
    for i = 1, x, 1 do
        turtle.back()
    end
end

function moveUp(x)
    for i = 1, x, 1 do
        turtle.up()
    end
end
function moveDown(x)
    for i = 1, x, 1 do
        turtle.down()
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


function goToCoordsHorizontal(a,b)
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

function nextItemSlot()
    local cur = turtle.getSelectedSlot()
    turtle.select( ((cur-1)%16)+1)
end

function nextFullItemSlot()
    if ifInventoryIsEmptyOfBlocks() then
        return false
    end
    
    local inventory = getInventory()
    for i = 1, 16, 1 do
        local item =inventory[i]
        if item~=nil then
            turtle.select(item)
            return true
        end
    end
    return false
end

function ifCurrentSlotIsEmpty()
    return turtle.getItemCount() <=0
end

function getInventory()
    local inventory ={}
    for i = 1, 16, 1 do
        inventory[i]=turtle.getItemDetail(i)
    end
    return inventory
end


--TODO doesnt check if slot is blocks
function ifInventoryIsEmptyOfBlocks()
    local items = getInventory()

    for i = 1, 16, 1 do
        local cur = items[i]
        print(i..": ")
        if cur ~= nil then    
            print("Item name: ", cur.name)
            print("Item count: ", cur.count)
            return false
        end
    end
    return true

end