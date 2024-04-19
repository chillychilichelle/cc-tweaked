
function manhattan(a, b)
    x1 = a[1]
    y1 = a[2]

    x2 = b[1]
    y2 = b[2]

    return math.abs(x1 - x2) + math.abs(y1 - y2)
end


function manhattan3d(a, b)
    x1 = a[1]
    y1 = a[2]
    z1 = a[3]

    x2 = b[1]
    y2 = b[2]
    z2 = b[3]

    return math.abs(x1 - x2) + math.abs(y1 - y2) + math.abs(z1 - z2)
end

function deepCopyTable(arr)
    local copy = {}
    for i, v in ipairs(arr) do
        if type(v) == "table" then
            copy[i] = deepCopyTable(v) -- Recursively clone nested tables
        else
            copy[i] = v
        end
    end
    return copy
end

function printTable(data, recursionNum)
    if recursionNum == nil then
        recursionNum = 0
    end
    for key, value in pairs(data) do
        if (type(value) == "table") then
            for i = 1, recursionNum, 1 do
                print(" ")
            end
            print(key .. "/")
            printTable(value, recursionNum + 1)
        else
            for i = 1, recursionNum, 1 do
                print(" ")
            end
            print(key .. "/ " .. tostring(value))
        end
    end
end

function writeTableToFile(data, fileName)
    if (fs.exists(fileName)) then
        fs.delete(fileName)
    end
    local file = fs.open(fileName, "w")

    local function f(_data, recursionNum)
        for key, value in pairs(_data) do
            if (type(value) == "table") then
                for i = 1, recursionNum, 1 do
                    file.write(" ")
                end
                file.write(key .. "/\n")
                f(value, recursionNum + 1)
            else
                for i = 1, recursionNum, 1 do
                    file.write(" ")
                end
                file.write(key .. "/" .. tostring(value) .. "\n")
            end
        end
    end
    f(data, 0)
    file.close()
end

function writeToFile(data, fileName)
    if (fs.exists(fileName)) then
        fs.delete(fileName)
    end
    local file = fs.open(fileName, "w")
    file.write(data)
    file.close()
end

function prefix(word, prefix)
    local s = word:sub(1, #prefix)
    if s == prefix then
        return word
    end
    return prefix .. word
end

function suffix(word, suffix)
    local s = word:sub(-(#suffix))
    if s == suffix then
        return word
    end
    return word .. suffix
end
