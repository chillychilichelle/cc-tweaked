local args  = {...}
local target = args[1]
rednet.broadcast(target)