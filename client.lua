local createdBlips = {}

if Config.EnableBlips then
    Citizen.CreateThread(function()
        for _, blipinfo in pairs(Config.Spots) do
            local blip = N_0x554d9d53f696d002(1664425300, blipinfo.spot.x, blipinfo.spot.y, blipinfo.spot.z)
            Citizen.InvokeNative(0x662D364ABF16DE2F, blip, Config.BlipModifierHash)
            SetBlipSprite(blip, Config.BlipSprite, 1)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, Config.BlipName)
            table.insert(createdBlips, blip)
        end
    end)
end

AddEventHandler("onResourceStop", function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, blip in ipairs(createdBlips) do
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
            end
        end
    end
end)