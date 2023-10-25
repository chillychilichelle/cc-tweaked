local pList = peripheral.getNames()

for index, value in ipairs(pList) do
    if(peripheral.getType(pList[index])== "modem")then
        rednet.open(pList[index])
    end
end