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