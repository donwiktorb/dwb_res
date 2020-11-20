RegisterNetEvent("dwb_res:Bye")
AddEventHandler("dwb_res:Bye", function()
	DropPlayer(source, 'dwb_res ' .. Config.KickMsg)
end)