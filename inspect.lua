require "utils"
local success, data = turtle.inspect()

if success then
    printArrayToFile(data,"data.txt")
    printArray(data)
end