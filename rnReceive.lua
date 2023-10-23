while true do
    local senderId, message, protocol =rednet.receive()
    print(senderId..": "..message)
    
end