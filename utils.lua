function manhattan(a, b)
    x1 = a[1]
    y1 = a[2]

    x2 = b[1]
    y2 = b[2]

    return math.abs(x1-x2)+math.abs(y1-y2)
end

function deepCopyArray(arr)
    local copy = {}
    for i, v in ipairs(arr) do
      if type(v) == "table" then
        copy[i] = deepCopyArray(v)  -- Recursively clone nested tables
      else
        copy[i] = v
      end
    end
    return copy
end

function printArray(data)
  for key, value in pairs(data) do
    if(type(value)=="table")then
      printArray(value)
    else
      print(key..": "..tostring(value))
    end
  end
end

function printArrayToFile(data, fileName)
  if(fs.exists(fileName)) then
      fs.delete(fileName)
  end
  local file = fs.open(fileName,"w")
  
  function f(_data)
    for key, value in pairs(_data) do
      if(type(value)=="table")then
        f(value)
      else
        file.write(key.."/"..tostring(value).."\n")
      end
    end
    
  end
  f(data)
  file.close()
end

function prefix(word, prefix)
  local s = word:sub(#prefix)
  if s==prefix then
    return word
  end
  return prefix..word
end

function suffix(word, suffix)
  local s = word:sub(-#suffix)
  if s==suffix then
    return word
  end
  return suffix..word
end