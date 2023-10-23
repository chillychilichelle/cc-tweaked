local files = fs.find("*.lua")

for i = 1, #files, 1 do
    print(files[i])
    fs.copy(files[i], "disk/"..files[i])

end