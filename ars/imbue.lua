package.path = package.path .. ";../?.lua"
require "turtleUtils"

turtle.select(1)

local curItem=turtle.getItemDetail()
local chamber= peripheral.find("inventory")
if(chamber==nil or curItem == nil) then return end
local original = curItem.name

turtle.suck()
while nextItemSlotOfType(original) do
    turtle.drop()
    while not isInventoryEmptyOfType(original,chamber.list()) do
        sleep(1)
    end
    turtle.suck()
end