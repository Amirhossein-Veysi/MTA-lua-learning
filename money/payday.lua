local PAYDAY_AMOUNT = 1000

function giveAccountPayDay(account)
    give(account, PAYDAY_AMOUNT)
end

function executePayday()
    local timeInterval = 1000 * 60 * 60 * 24
    setTimer(executePayday, timeInterval, 1)
    local currentTimestamp = getRealTime().timestamp
    local oneDay = 60 * 60 * 24
    local paidAccounts = {}

    for _, player in pairs(getElementsByType("player")) do
        local account = getPlayerAccount(player)
        if account then
            giveAccountPayDay(account)
            paidAccounts[getAccountName(account)] = true
            outputChatBox("You have received a daily payday of" .. PAYDAY_AMOUNT .. "!", player, 100, 255, 100)
        end
    end

    for _, account in pairs(getAccounts()) do
        local lastSeen = getAccountData(account, 'lass_seen') or 0
        if (currentTimestamp - lastSeen) < oneDay and not paidAccounts[getAccountName(account)] then
            giveAccountPayDay(account)
        end
    end
end

addEventHandler("onResourceStart", resourceRoot, function() 
    local time = getRealTime()
    local hour = time.hour * 1000 * 60 * 60
    local minute = time.minute * 1000 * 60
    local second = time.second * 1000 * 60
    local miliSecondsSinceMidnight = hour + minute + second
    local miliSecondsOfDay = 1000 * 60 * 60 * 24
    local timeInterval = miliSecondsOfDay - miliSecondsSinceMidnight

    setTimer(executePayday, timeInterval, 1)
end)
