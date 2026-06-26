local ESX

local function GetESX()
    if ESX then return ESX end
    pcall(function() ESX = exports[Config.ESXResource]:getSharedObject() end)
    if not ESX then
        pcall(function()
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        end)
    end
    return ESX
end

CreateThread(function()
    while not ESX do
        GetESX()
        Wait(500)
    end
end)

local function HasPermission(src)
    if src == 0 then return true end
    local esx = GetESX()
    if not esx then return false end
    local xPlayer = esx.GetPlayerFromId(src)
    if not xPlayer then return false end
    local group = xPlayer.getGroup()
    for _, allowed in ipairs(Config.AllowedGroups) do
        if group == allowed then return true end
    end
    return false
end

local function Feedback(src, message)
    if src == 0 then
        print(('[alx-ss] %s'):format(message))
    else
        TriggerClientEvent('chat:addMessage', src, {
            color = { 255, 0, 0 },
            args = { 'ScreenShare', message }
        })
    end
end

local function ResolveTarget(src, args, command)
    local target = tonumber(args[1])
    if not target then
        Feedback(src, ('Uso: /%s [id]'):format(command))
        return nil
    end
    if GetPlayerName(target) == nil then
        Feedback(src, 'El jugador no esta conectado.')
        return nil
    end
    return target
end

RegisterCommand(Config.OpenCommand, function(source, args)
    if not HasPermission(source) then return end
    local target = ResolveTarget(source, args, Config.OpenCommand)
    if not target then return end

    TriggerClientEvent('alx-ss:open', target)
    Feedback(source, ('ScreenShare activado al jugador %s.'):format(target))
end, false)

RegisterCommand(Config.CloseCommand, function(source, args)
    if not HasPermission(source) then return end
    local target = ResolveTarget(source, args, Config.CloseCommand)
    if not target then return end

    TriggerClientEvent('alx-ss:close', target)
    Feedback(source, ('ScreenShare cerrado al jugador %s.'):format(target))
end, false)
