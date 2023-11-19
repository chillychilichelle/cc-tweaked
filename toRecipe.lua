print("Name the result recipe (Don't include \".txt\"): ")
local path = "recipes/"
local fileName = read()
fileName= fileName..".txt"

if(fs.exists(path..fileName)) then
    print("Overwriting data...")
    fs.delete(path..fileName)
end

print("Press enter when all items are in place...")
read()

local file = fs.open(path..fileName,"w")
for x = 1, 3, 1 do
    for y = 1, 3, 1 do
        local slot = y+(x-1)*4;
        local item =turtle.getItemDetail(slot)
        if(item~=nil)then
            file.write(slot.."/"..item.name.."\n")
        end
    end
    file.write("\n")    
end


file.close()