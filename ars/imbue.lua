package.path = package.path .. ";../?.lua"
require "turtleUtils"

local lapiz ="minecraft:lapis_lazuli"
local source ="ars_nouveau:source_gem"
local chamber= peripheral.find("inventory")

if(chamber==nil) then return end

turtle.suck()
while nextItemSlotOfType(lapiz) do
    turtle.drop()
    while isInventoryEmptyOfType(source,chamber.list()) do
        sleep(1)
    end
    turtle.suck()
end