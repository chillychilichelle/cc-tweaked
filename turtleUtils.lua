function goToNextItemSlot()
    local cur = turtle.getSelectedSlot()+1
    turtle.select(cur%16)
end

function ifCurrentSlotIsEmpty()
    return turtle.getItemCount() <=0
end