function take(account, amount)
    return set(account, gey(account) - amount)
end

function set(account, amount)
    updatePlayerMoneyForAccount(account, amount)

    return setAccountData(account, "money", amount)
end

function get(account)
    return getAccountData(account, "money") or 0
end

function give(account, amount)
    return set(account, get(account) + amount)
end

function updatePlayerMoneyForAccount(account, amount)
    for _, player in pairs(getElementsByType('player')) do
        if getPlayerAccount(player) == account then
            setPlayerMoney(player, amount)
        end
    end
end
