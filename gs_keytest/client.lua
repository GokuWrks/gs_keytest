ESX = nil -- Für die ESX funktionen

local version = config.esx
if version == "oldesx" then
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
    end
end)
elseif version == "newesx" then
ESX = exports['es_extended']:getSharedObject()
end

local x = config.coords.x
local y = config.coords.y
local z = config.coords.z
local h = config.coords.h
local playerId = GetPlayerServerId(PlayerId()) -- Definiere den Spieler für die ID
local npcCoords = vector3(x,y,z) -- Definiere die Koordinaten für den NPC-Standort
local type = config.type

if type == "all" or type == "npc" then

    -- Erstelle die Funktion zum Erzeugen des NPCs
   local EnablePeds = config.EnablePeds
   local FreezePeds = config.FreezePeds
   local GodPeds = config.GodPeds
    
      Citizen.CreateThread(function()
        for k,v in pairs(config.blips) do
            local blip = AddBlipForCoord(x, y, z)
    
            SetBlipSprite(blip, v.blip.Sprite)
            SetBlipScale(blip, v.blip.Scale)
            SetBlipColour(blip, v.blip.Colour)
            SetBlipDisplay(blip, v.blip.Display)
            SetBlipAsShortRange(blip, true)
    
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end)
    
    
    Citizen.CreateThread(function()
        if EnablePeds then
            for eji,_ in pairs(config.locations) do
                RequestModel(GetHashKey(config.npc))
                
                while not HasModelLoaded(GetHashKey(config.npc)) do
                    Wait(100)
                end
                local npc = CreatePed(4, config.npc, x, y, z, h, false, true)
                SetEntityHeading(npc, h)
                FreezeEntityPosition(npc, FreezePeds)
                SetEntityInvincible(npc, GodPeds)
                SetBlockingOfNonTemporaryEvents(npc, true)
            end	
        end
    end)
    
    Citizen.CreateThread(function()
        while true do
            Wait(0)
            local coords  = GetEntityCoords(GetPlayerPed(-1))
            if(GetDistanceBetweenCoords(coords, x, y, z, 331, true) < 2) then
                isInMarker2  = true
            else
                isInMarker2 = false
            end
            if isInMarker2 then   
                -- ESX.TextUI("Drücke ~p~E~s~ zum Interagieren") -- export um die costum textUI zu zeigen               
                ESX.ShowHelpNotification("Drücke ~p~E~s~ zum Interagieren")
                if IsControlJustReleased(0, 38) then
                    config.event(config.message)
                    Wait(10)
                end
            else
                --  ESX.HideUI() -- export um die costum textUI zu verstecken
            end
        end
    end)
end

if type == "all" or type == "key" then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            if IsControlJustReleased(0, config.key) then  -- "E"-Taste
                config.event(config.message) -- Hier die gewünschte Notify-Nachricht ändern
            end
        end
    end)
end

if type == "all" or type == "cmd" then
    RegisterCommand(config.command, function(source, args)
        config.event(config.message) -- Hier die gewünschte Notify-Nachricht ändern
    end)
end
