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

function printArray(arr)
  for i = 1, #arr, 1 do
    print("["..i.."]: "..arr[i])
  end
end