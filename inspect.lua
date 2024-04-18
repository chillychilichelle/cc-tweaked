require "utils"
local success, data = turtle.inspect()

if success then
    writeTableToFile(data,"data.txt")
    printTable(data)
end