function getVehicleFromId(player, id)
    if (id == '*') then                
        local vehicle = getPedOccupiedVehicle(player)
        return vehicle
    else
        local vehicles = getElementsByType('vehicle')

        for _, vehicle in pairs(vehicles) do
            if (tonumber(getElementData(vehicle, 'id')) == tonumber(id)) then
                outputChatBox("found it :|")
                return vehicle
            end
        end
    end
end