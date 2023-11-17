require "utils"
local item = turtle.getItemDetail()

if(item ~=nil) then
    printArrayToFile(item,"data.txt")
end
