--TODO this only works when target is the first folder
-- meaning it works when copying to disk/ or disk2/ but not to disk/subfolder/
-- it will copy its parent folders into the subfolders
function copyFiles(source, target)
    
    source = source or ""
    source = source.."/"

    target = target or "disk"
    target = target.."/"

    print("Copying from: "..source.." to "..target)
    local files = fs.find(source.."*")
    for i = 1, #files, 1 do
        if(fs.isDir(files[i])) then
            if(files[i]~="rom" and files[i]~=target) then
                print("Branching to: "..files[i]..'/')
                copyFiles(files[i]..'/')
            end         
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
copyFiles(args[0], args[1])

