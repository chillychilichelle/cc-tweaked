local args ={...}
local path = args[0] or "/"
copyFiles(path)

function copyFiles(path)
    local files = fs.find(path.."*")
    for i = 1, #files, 1 do
        print(files[i])
        if(fs.isDir(files[i])) then
            copyFiles(path..files[i])
        else
            local newName = "disk"..path.."/"..files[i]
            if(fs.exists(newName)) then
                fs.delete(newName)
            end
            fs.copy(files[i], newName)
        end
    end
end