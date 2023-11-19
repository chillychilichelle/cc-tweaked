require("utils")
print("Name the resulting recipe file: ")
local fileName = read()

fileName = prefix(fileName,"recipes/")
fileName = suffix(fileName,".txt")

if(fs.exists(fileName)) then
    print("Overwriting data...")
    fs.delete(fileName)
end

print("Press enter when all items are in place...")
read()

local file = fs.open(fileName,"w")
for x = 1, 3, 1 do
    for y = 1, 3, 1 do
        local slot = y+(x-1)*4;
        local item =turtle.getItemDetail(slot)
        if(item~=nil)then
            local s = slot.."/"..item.name.."\n"
            print(s)
            file.write(s)
        end
    end
end

file.close()