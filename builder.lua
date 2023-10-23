local args  = {...}
local target = args[1]
print("Attempting to build "..target.." ...")

if(!fs.exists(target)) then
    print("The blueprint does not exist...")
    return
end

print("Reading "..target+" ...")
local file = fs.open(target,"r")
local x = tonumber(file.readLine())
local y = tonumber(file.readLine())
local z = tonumber(file.readLine())
print("X: "..x.." Y: "..y.." Z: "..z)

file.close()