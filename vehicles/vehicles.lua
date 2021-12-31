function createVehicleForPlayer(player, command, model)
    local db = exports.db.getConnection()
    local x, y, z = getElementPosition(player)
    local rx, ry, rz = getElementRotation(player)
    y = y + 5

    dbExec(db, 'INSERT INTO vehicles (model, x, y, z, rx, ry, rz, health) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', model, x, y, z, rx, ry, rz, 1000);
    local vehicleObject = createVehicle(model, x, y, z, xr, yr, zr)

    dbQuery(function(queryHandle)
        local results = dbPoll(queryHandle, 0)
        local vehicle = results[1]

        setElementData(vehicleObject, 'id', vehicle.id)

    end, db, 'SELECT id FROM vehicles ORDER BY id DESC LIMIT 1')
end
addCommandHandler('createvehicle', createVehicleForPlayer, false, false)

function loadAllVehicles(queryHandle)
    local results = dbPoll(queryHandle, 0)

    for index, vehicle in pairs(results) do
        local vehicleObject = createVehicle(vehicle.model, vehicle.x, vehicle.y, vehicle.z, vehicle.rx, vehicle.ry, vehicle.rz)

        setElementHealth(vehicleObject, vehicle.health)
        setVehicleColor(vehicleObject, vehicle.c1, vehicle.c2, vehicle.c3, vehicle.c4)
        setElementData(vehicleObject, "id", vehicle.id)
    end
end

addEventHandler("onResourceStart", resourceRoot, function()
    local db = exports.db.getConnection()
    dbQuery(loadAllVehicles, db, 'SELECT * FROM vehicles')
end)

addEventHandler("onResourceStop", resourceRoot, function()
    local db = exports.db.getConnection()
    local vehicles = getElementsByType('vehicle')

    for index, vehicle in pairs(vehicles) do
        local id = getElementData(vehicle, 'id')
        local x, y, z = getElementPosition(vehicle)
        local rx, ry, rz = getElementRotation(vehicle)
        local health = getElementHealth(vehicle)
        local c1, c2, c3, c4 = getVehicleColor(vehicle, false)

        dbExec(db, 'UPDATE vehicles SET x = ?, y = ?, z = ?, rx = ?, ry = ?, rz = ?, health = ?, c1 = ?, c2 = ?, c3 = ?, c4 =? WHERE id = ?', x, y, z, rx, ry, rz, health, c1, c2, c3, c4, id)
    end
end)
