-- https://pastebin.com/uePgaAnd
-- pastebin get uePgaAnd gh.lua

local args  = {...}
local target = args[1]
print("Attempting to download "..target.." ...")
local download = http.get("https://raw.githubusercontent.com/chillychilichelle/cc-tweaked/main/"..target)
local handle = download.readAll()
download.close()

if(fs.exists(target)) then
    print("Overwriting data...")
    fs.delete(target)
end

local file = fs.open(target,"w")
print(target.." downloaded!")

file.write(handle)
file.close()