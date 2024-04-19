function TurtleState(_coords, _orientation)
    ORIGIN = {0, 0, 0}
    local self = {}
    if _coords == nil then
        _coords = {0, 0, 0}
    end
    if _orientation == nil then
        _orientation = 0
    end

    self.coords = {}
    self.coords[1] = _coords[1]
    self.coords[2] = _coords[2]
    self.coords[3] = _coords[3]

    self.rotationLock = false;
    self.destructionLock = false;

    -- 0 FORWARD    -Z
    -- 1 RIGHT      +X
    -- 2 BACK       +Z
    -- 3 LEFT       -X
    self.orientation = _orientation

    

    function self.moveUp(x)
        for i = 1, x, 1 do
            if turtle.detectUp() and not self.destructionLock then
                turtle.digUp()
            end
            if turtle.up() then
                self.coords[2] = self.coords[2] + 1
            end
        end
    end

    function self.moveDown(x)
        for i = 1, x, 1 do
            if turtle.detectDown() and not self.destructionLock then
                turtle.digDown()
            end
            if turtle.down() then
                self.coords[2] = self.coords[2] - 1
            end
        end
    end

    function self.moveForward(x)
        for i = 1, x, 1 do
            if turtle.detect() and not self.destructionLock then
                turtle.dig()
            end
            if turtle.forward() then
                if self.orientation == 0 then
                    self.coords[3] = self.coords[3] - 1
                elseif self.orientation == 1 then
                    self.coords[1] = self.coords[1] + 1
                elseif self.orientation == 2 then
                    self.coords[3] = self.coords[3] + 1
                elseif self.orientation == 3 then
                    self.coords[1] = self.coords[1] - 1
                end
            end
        end
    end


    function self.getXZ()
        local x = self.coords[1]
        local z = self.coords[3]
        return {x, z}
    end

    -- 0 FORWARD
    -- 1 RIGHT
    -- 2 BACK
    -- 3 LEFT
    function self.rotateTo(dirNum)
        if self.orientation == dirNum then
            return
        end

        if self.orientation == 0 then
            if dirNum == 1 then
                turtle.turnRight()
            elseif dirNum == 2 then
                turtle.turnRight()
                turtle.turnRight()
            elseif dirNum == 3 then
                turtle.turnLeft()
            end
        elseif self.orientation == 1 then
            if dirNum == 0 then
                turtle.turnLeft()
            elseif dirNum == 2 then
                turtle.turnRight()
            elseif dirNum == 3 then
                turtle.turnRight()
                turtle.turnRight()
            end
        elseif self.orientation == 2 then
            if dirNum == 0 then
                turtle.turnRight()
                turtle.turnRight()
            elseif dirNum == 1 then
                turtle.turnLeft()
            elseif dirNum == 3 then
                turtle.turnRight()
            end
        elseif self.orientation == 3 then
            if dirNum == 0 then
                turtle.turnRight()
            elseif dirNum == 1 then
                turtle.turnRight()
                turtle.turnRight()
            elseif dirNum == 2 then
                turtle.turnLeft()
            end
        end

        self.orientation = dirNum;
    end

    --TODO: when using full control, forward is -Z, in restrained, forward is +Z. Needs regularizing, possibly when replacing deprecated functions
    --TODO: assumes will never be blocked
    --TODO: assumes will never be in 2 or 3
    function self.moveToHorizontal(target)
        local function moveToHorizontalFullTurn(self, target)
            local x1 = self.coords[1]
            local z1 = self.coords[3]

            local x2 = target[1]
            local z2 = target[2]

            local xDif = x2 - x1
            if (xDif > 0) then
                self.rotateTo(1)
            elseif (xDif < 0) then
                self.rotateTo(3)
            end
            self.moveForward(math.abs(xDif))

            local zDif = z2 - z1
            if (zDif < 0) then
                self.rotateTo(0)
            elseif (zDif > 0) then
                self.rotateTo(2)
            end
            self.moveForward(math.abs(zDif))
        end

        local function moveToHorizontalConstrainedTurn(self, target)
            local x1 = self.coords[1]
            local z1 = self.coords[3]

            local x2 = target[1]
            local z2 = target[2]

            local xDif = x2 - x1
            if (xDif > 0) then
                if (self.orientation ~= 1) then
                    turtle.turnRight()
                    self.orientation = 1
                end
                moveForward(xDif)
            elseif (xDif < 0) then
                if (self.orientation ~= 1) then
                    turtle.turnRight()
                    self.orientation = 1
                end
                moveBack(-xDif)
            end

            local zDif = z2 - z1
            if (zDif > 0) then
                if (self.orientation ~= 0) then
                    turtle.turnLeft()
                    self.orientation = 0
                end
                moveForward(zDif)
            elseif (zDif < 0) then
                if (self.orientation ~= 0) then
                    turtle.turnLeft()
                    self.orientation = 0
                end
                moveBack(-zDif)
            end

            self.coords[1] = target[1]
            self.coords[3] = target[2]
        end

        if (self.rotationLock == false) then
            moveToHorizontalFullTurn(self, target)
        else
            moveToHorizontalConstrainedTurn(self, target)
        end
    end
    
    function self.moveToVertical(y2)
        local y1 = self.coords[2]
        local yDif = y2 - y1
        if (yDif > 0) then
            self.moveUp(yDif)
        elseif (yDif < 0) then
            self.moveDown(-yDif)
        end

    end

    return self
end

--TODO: deprecate these
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

function goToCoordsHorizontal(a, b)
    local x1 = a[1]
    local y1 = a[2]

    local x2 = b[1]
    local y2 = b[2]

    local xDif = x2 - x1
    if (xDif > 0) then
        moveRight(xDif)
    elseif (xDif < 0) then
        moveLeft(-xDif)
    end

    local yDif = y2 - y1
    if (yDif > 0) then
        moveForward(yDif)
    elseif (yDif < 0) then
        moveBack(-yDif)
    end
end

function nextItemSlot()
    local cur = turtle.getSelectedSlot()
    turtle.select((cur % 16) + 1)
end

function nextFullItemSlot()
    local inventory = getInventory()
    local cur = turtle.getSelectedSlot()
    for i = 1, 16, 1 do
        cur = (cur % 16) + 1
        local item = inventory[cur]
        if item ~= nil then
            turtle.select(cur)
            return true
        end
    end
    return false
end
function nextItemSlotOfType(name)
    local inventory = getInventory()
    local cur = turtle.getSelectedSlot()
    for i = 1, 16, 1 do
        cur = (cur % 16) + 1
        local item = inventory[cur]
        if item ~= nil and item.name == name then
            turtle.select(cur)
            return true
        end
    end
    return false
end

function isCurrentSlotEmpty()
    return turtle.getItemCount() <= 0
end
function isCurrentSlotOfType(name)
    if turtle.getItemDetail() == nil then
        return false
    end
    return turtle.getItemDetail().name == name
end

function getInventory()
    local inventory = {}
    for i = 1, 16, 1 do
        inventory[i] = turtle.getItemDetail(i)
    end
    return inventory
end

--TODO doesnt check if slot is blocks
function isInventoryEmpty()
    local items = getInventory()
    for i = 1, 16, 1 do
        local item = items[i]
        if item ~= nil then
            return false
        end
    end
    return true
end

function isInventoryEmptyOfType(name, targetInventory)
    local items
    if targetInventory ~= nil then
        items = targetInventory
    else
        items = getInventory()
    end

    for i = 1, 16, 1 do
        local item = items[i]
        if item ~= nil and item.name == name then
            return false
        end
    end
    return true
end
