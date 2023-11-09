function copyFiles(path)
    print("Copying: "..path)
    local files = fs.find(path.."*")
    for i = 1, #files, 1 do
        if(fs.isDir(files[i])) then
            print("Branching to: "..path..files[i]..'/')
            copyFiles(path..files[i]..'/')
        else
            --print("Copying file: "..files[i])
            local newName = "disk/"..files[i]
            if(fs.exists(newName)) then
                fs.delete(newName)
            end
            fs.copy(files[i], newName)
        end
    end
end

local args ={...}
local path = args[0] or "/"
copyFiles(path)

