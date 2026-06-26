local active = false
local sessionId = 0
local originalCoords = nil
local originalHeading = nil
local CloseUI

local function SetBags(state)
    if not Config.SetStateBags then return end
    LocalPlayer.state:set('screenShare', state and true or false, true)
    if state then
        LocalPlayer.state:set('gamemode', Config.GamemodeValue, true)
    else
        LocalPlayer.state:set('gamemode', nil, true)
    end
end

local function OpenUI()
    if active then return end
    active = true
    sessionId = sessionId + 1
    local mySession = sessionId

    local ped = PlayerPedId()
    originalCoords = GetEntityCoords(ped)
    originalHeading = GetEntityHeading(ped)

    SetNuiFocus(true, true)
    SetEntityCoords(ped, Config.Coords.x, Config.Coords.y, Config.Coords.z, false, false, false, false)
    SetEntityHeading(ped, Config.Coords.heading or 0.0)

    if Config.FreezePlayer then FreezeEntityPosition(ped, true) end
    if Config.InvinciblePlayer then SetEntityInvincible(ped, true) end

    SetBags(true)

    SendNUIMessage({
        type = 'openUI',
        config = {
            duration     = Config.Duration,
            alertAt      = Config.AlertAtSecond,
            playEndVideo = Config.PlayEndVideo,
            title        = Config.UI.title,
            message      = Config.UI.message,
            footer       = Config.UI.footer,
            button       = Config.UI.button,
            requester    = Config.UI.requester,
            discord      = Config.UI.discord,
        }
    })

    CreateThread(function()
        local timeout = (Config.Duration or 30) + (Config.EndVideoMaxSeconds or 20)
        Wait(timeout * 1000)
        if active and sessionId == mySession then
            CloseUI(true)
        end
    end)
end

CloseUI = function(restore)
    active = false
    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'closeUI' })

    local ped = PlayerPedId()
    if Config.FreezePlayer then FreezeEntityPosition(ped, false) end
    if Config.InvinciblePlayer then SetEntityInvincible(ped, false) end

    if restore and Config.RestorePosition and originalCoords then
        SetEntityCoords(ped, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, false)
        SetEntityHeading(ped, originalHeading or 0.0)
    end

    SetBags(false)
end

RegisterNetEvent('alx-ss:open', OpenUI)
RegisterNetEvent('alx-ss:close', function() CloseUI(true) end)

RegisterNUICallback('closeUI', function(_, cb)
    CloseUI(true)
    cb('ok')
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    active = false
    SetNuiFocus(false, false)
    SendNUIMessage({ type = 'closeUI' })
    SetBags(false)
end)

AddEventHandler('onClientResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end
    local ped = PlayerPedId()
    SetNuiFocus(false, false)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    if active and Config.RestorePosition and originalCoords then
        SetEntityCoords(ped, originalCoords.x, originalCoords.y, originalCoords.z, false, false, false, false)
        SetEntityHeading(ped, originalHeading or 0.0)
    end
    SetBags(false)
end)
