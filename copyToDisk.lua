local files = fs.find("*.lua")

for i = 1, #files, 1 do
    print(files[i])
    local newName = "disk/"..files[i]
    if(fs.exists(newName)) then
        fs.delete(newName)
    end

    fs.copy(files[i], newName)

end