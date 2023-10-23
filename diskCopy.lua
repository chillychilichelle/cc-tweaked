local files = fs.list("")

for i = 1, #files, 1 do
    print(files[i])
end