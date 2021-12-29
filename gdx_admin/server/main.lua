ESX = nil
local active = false

TriggerEvent(Config.GetSharedObject, function(obj)
    ESX = obj 
end)

RegisterCommand(Config.AdminPedCMD, function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "admin" then
        if active == false then
            TriggerClientEvent("gdx_admin:setPlayer", source)
            active = true
        else
            TriggerClientEvent("gdx_admin:setAdmin", source)
            active = false
        end
    else
        Notif(source, _U('no_perm'))
    end
end)

function Notif(source, text)
    if Config.NotificationType == "esx" then
        TriggerClientEvent('esx:showNotification', source, text)
    elseif Config.NotificationType == "t-notify" then
        TriggerClientEvent('t-notify:client:Custom', source, {
            style = 'info',
            title = 'Admin',
            message = '',
            duration = 3000,
            sound = true
        })
    elseif Config.NotificationType == "okok" then
        TriggerClientEvent('okokNotify:Alert', source, "Admin", text, 3000, 'error')
    elseif Config.NotificationType == "other" then
        -- set here your notification
    else
        print("^2["..Config.Resource.."]^0 ".._U('notify_error'))
    end
end
