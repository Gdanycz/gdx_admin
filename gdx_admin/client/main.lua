ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('gdx_admin:setPlayer')
AddEventHandler('gdx_admin:setPlayer', function()
	ClearPedSecondaryTask(PlayerPedId())
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		local model = nil
		
		if skin.sex == 0 then
        	model = GetHashKey("mp_m_freemode_01")
     	else
         	model = GetHashKey("mp_f_freemode_01")
        end

			RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Citizen.Wait(1)
        end

          	SetPlayerModel(PlayerId(), model)
          	SetModelAsNoLongerNeeded(model)

          	TriggerEvent('skinchanger:loadSkin', skin)
			TriggerEvent('esx:restoreLoadout')
		end)
end)

RegisterNetEvent('gdx_admin:setAdmin')
AddEventHandler('gdx_admin:setAdmin', function()
local ped = 's_m_y_dockwork_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash) do 
		RequestModel(hash)
		Citizen.Wait(0)
	end	
		SetPlayerModel(PlayerId(), hash)
		TriggerEvent('esx:restoreLoadout')
end)
