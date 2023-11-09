local files = fs.find("disk/*.lua")

for i = 1, #files, 1 do
    print(files[i])
    local newName = files[i]
    if(fs.exists(newName)) then
        fs.delete(newName)
    end

    fs.copy(files[i], newName)

end

local txtFiles = fs.find("disk/*.txt")
for i = 1, #txtFiles, 1 do
    print(txtFiles[i])
    local newName = txtFiles[i]
    if(fs.exists(newName)) then
        fs.delete(newName)
    end

    fs.copy(txtFiles[i], newName)

end