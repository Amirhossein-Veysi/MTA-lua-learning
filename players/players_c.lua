local isHUDVisible = true;

addEventHandler( "onClientKey", root, function(button, press)
    if button == 'F5' and not press then
        isHUDVisible = not isHUDVisible
        setPlayerHudComponentVisible ('all', not isHUDVisible)
        return true
    end
    return false
end )
