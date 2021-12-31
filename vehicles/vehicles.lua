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

function lockcar (player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle then
        if isVehicleLocked ( vehicle ) then
            setVehicleLocked ( vehicle, false )
            outputChatBox("vehicle isn't locked", player, 100, 100, 255)
        else
            setVehicleLocked ( vehicle, true )
            outputChatBox("vehicle is locked", player, 100, 100, 255)
        end
    end
end

function changeEngine(player)
    local vehicle = getPedOccupiedVehicle(player)
    if vehicle then
        if getVehicleEngineState(vehicle) then
            setVehicleEngineState(vehicle, false)
        else
            setVehicleLocked ( vehicle, true)
        end
    end
end

function bindLockOnSpawn ( theSpawnpoint )
    bindKey ( source, "l", "down", lockcar)
    bindKey(source, "o", "down", changeEngine)
end
addEventHandler ( "onPlayerSpawn", root, bindLockOnSpawn ) 

function turnEngineOff ( theVehicle, leftSeat, jackerPlayer )
    -- if it's the driver who got out, and he was not jacked,
    if leftSeat == 0 and not jackerPlayer then
        -- turn off the engine
        setVehicleEngineState ( theVehicle, false )
    end
end
-- add 'turnEngineOff' as a handler for "onPlayerExitVehicle"
addEventHandler ( "onPlayerVehicleExit", root, turnEngineOff )
