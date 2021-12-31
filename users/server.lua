function outButDxChat (Text,player,r,p,g)
	exports["guimessages"]:outputServer(player,Text,r,p,g)
end

function loginPlayer(player, username, password)
	local db = exports.db.getConnection();
	dbQuery(function(queryHandle)
		local result = dbPoll(queryHandle, 0)
		if result then
			logIn(player, getAccount(username), password)
			triggerClientEvent(player, "onClientPlayerLogin", getRootElement())
		end
	end, db, 'SELECT id FROM users WHERE username = ? AND password = ?', username, password)
end
addEvent("login", true)
addEventHandler("login", getRootElement(), loginPlayer)

function registerPlayer(player, email, username, password)
	local getacc = getAccount(username)
	outputDebugString(tostring(player))
	if getacc == false then
		local db = exports.db.getConnection()
		local serial = getPlayerSerial(player)
		dbExec(db, 'INSERT INTO users (email, username, password, serial) VALUES (?, ?, ?, ?)', email, username, password, serial);
		local account = addAccount(tostring(username), tostring(password))
		if account then
			logIn(player, account, tostring(password))
			triggerClientEvent(player, "onClientPlayerLogin", getRootElement())
		end
	end
end
addEvent("register", true)
addEventHandler("register", getRootElement(), registerPlayer)