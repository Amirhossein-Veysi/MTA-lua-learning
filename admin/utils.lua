function getVehicleFromId(player, id)
    if (id == '*') then                
        local vehicle = getPedOccupiedVehicle(player)
        return vehicle
    else
        local vehicles = getElementsByType('vehicle')

        for _, vehicle in pairs(vehicles) do
            if (tonumber(getElementData(vehicle, 'id')) == tonumber(id)) then
                return vehicle
            end
        end
    end
end

function getPositionInFrontOf(player)
    local rx, ry, rz = getElementRotation(player)
    rz = rz + 90

    local desiredRelativePosition = Vector3(0, 5, 0)
    local matrix = player.matrix
    local newPosition = matrix:transformPosition(desiredRelativePosition)

    local interior = getElementInterior(player)
    local demension = getElementDimension(player)

    return newPosition:getX(), newPosition:getY(), newPosition:getZ(), rx, ry, rz, interior, demension
end