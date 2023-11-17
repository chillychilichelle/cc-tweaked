require "turtleUtils"

local lapiz ="minecraft:lapis_lazuli"
local source ="ars_nouveau:source_gem"
local chamber= peripheral.find("inventory")
turtle.suck()
while nextItemSlotOfType(lapiz) do
    turtle.drop()
    while isInventoryEmptyOfType(source,chamber) do
        sleep(1)
    end
    turtle.suck()
end