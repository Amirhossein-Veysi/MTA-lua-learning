addCommandHandler('fixcar', function (player, command, id)
    if not id then
        return outputChatBox("Syntax: /" .. command .. " [id] or pass * if you want the car that you're in", player, 255, 100, 100)
    end

    local vehicle = exports.admin:getVehicleFromId(player, id)

    if not vehicle then
        return outputChatBox("The vehicle doesn't exist!", player, 255, 100 , 100)
    end

    fixVehicle(vehicle)
    outputChatBox("The vehicle has been successfully repaired!", player, 100, 255, 100)
end)

addCommandHandler('getcar', function (player, command, id)
    if not id then
        return outputChatBox("Syntax: /" .. command .. " [id]", player, 255, 100, 100)
    end

    local vehicle = exports.admin:getVehicleFromId(player, id)
    local x, y, z, rx, ry, rz, interior, demension = exports.admin:getPositionInFrontOf(player)

    if not vehicle then
        return outputChatBox("The vehicle doesn't exist!", player, 255, 100, 100)
    end

    setElementPosition(vehicle, x, y, z)
    setElementRotation(vehicle, rx, ry, rz)
    setElementInterior(vehicle, interior)
    setElementDimension(vehicle, demension)
    outputChatBox("Teleported the vehicle" .. vehicle.id .. '!', player, 100, 255, 100)
end)
