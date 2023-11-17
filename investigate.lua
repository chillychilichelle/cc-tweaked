local item = turtle.getItemDetail()

for key, value in pairs(item) do
    print(key..": "..value)
end