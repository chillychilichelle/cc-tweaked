-- https://pastebin.com/uePgaAnd
-- uePgaAnd

local args  = {...}
local target = args[1]
local download = http.get("https://raw.githubusercontent.com/chillychilichelle/cc-tweaked/main/"..target)
local handle = download.readAll()
download.close()

if(fs.exists(target)) then
    print("Overwriting data...")
    fs.delete(target)
end

local file = fs.open(target,"w")
file.write(handle)
file.close()