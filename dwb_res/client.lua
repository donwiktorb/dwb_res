local IsWide = false

Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(Config.CheckTimer)
        local res = GetIsWidescreen()
        if not res and not IsWide then
            startTimer()
            IsWide = true
        elseif res and IsWide then
            IsWide = false
        end
	end
end)

function startTimer()
	local timer = Config.Timer

	Citizen.CreateThread(function()
		while timer > 0 and IsWide do
			Citizen.Wait(1000)

			if timer > 0 then
                timer = timer - 1
                if timer == 0 then
                    TriggerServerEvent("dwb_res:Bye")
                end
			end
		end
	end)

	Citizen.CreateThread(function()
		while IsWide do
			Citizen.Wait(Config.MsgTimer)
			draw(string.format(Config.ChangeResMsg, timer))
		end
	end)
end

function draw(text) 
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	ThefeedNextPostBackgroundColor(184)
	PlaySound(-1, "SELECT", 'HUD_MINI_GAME_SOUNDSET', 0, 0, 1);
	ThefeedSetAnimpostfxCount(1)
	ThefeedSetAnimpostfxColor(34, 138, 21, 255)
	EndTextCommandThefeedPostTicker(true, true)
end