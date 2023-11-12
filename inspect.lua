local success, data = turtle.inspect()

if success then
    for key, value in pairs(data) do
        print(key..": "..value)
    end
end