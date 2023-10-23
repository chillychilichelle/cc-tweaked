function goToNextItemSlot()
    local cur = turtle.getSelectedSlot()
    turtle.select( (cur%16)+1)
end

function ifCurrentSlotIsEmpty()
    return turtle.getItemCount() <=0
end