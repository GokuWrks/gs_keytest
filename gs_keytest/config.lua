config = {}
local playerId = GetPlayerServerId(PlayerId()) -- Definiere den Spieler für die ID

config.esx = "newesx" -- oldesx / newesx
config.type = "npc" -- key / cmd / npc / all

config.coords = { x = -429.04, y = 1110.75, z = 326.6907, h = 340.81} -- NPC position -79.3792, -819.9918, 326.1752, 139.8611

config.npc = "a_m_y_business_01" -- NPC model

config.locations = { ["test"] = {}, } 

config.EnablePeds = true --Enables/Disables Ped Spawning
    
config.FreezePeds = true --Enables/Disables ob das ped freezed ist 

config.GodPeds = true --Enables/Disables ob das ped godmode haben soll

config.blips = {
	{
	
		blip = {
		  Name = "Test",
		  Sprite = 568,
		  Scale = 0.7,
		  Colour = 36,
		  Display = 2
		},
	}
  }

config.command = "test" -- command

config.key = 38 -- "E"

config.message = "Spieler ID: ~p~".. playerId.. "~s~"

config.event = function(msg)
    return ESX.ShowNotification(msg) 
end
