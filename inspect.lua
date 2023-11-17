require "utils"
local success, data = turtle.inspect()

if success then
    printArrayToFile(data)
end