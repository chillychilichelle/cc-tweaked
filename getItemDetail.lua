require "utils"
local item = turtle.getItemDetail()

if(item ~=nil) then
    writeTableToFile(item,"data.txt")
    printTable(item)
end
