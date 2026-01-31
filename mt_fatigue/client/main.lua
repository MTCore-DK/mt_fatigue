local fatigue = 0
local lastMove = GetGameTimer()
local isAFK = false

CreateThread(function()
    while true do
        Wait(1000)

        local ped = PlayerPedId()
        local speed = GetEntitySpeed(ped)

        if speed > 0.1 then
            fatigue = math.max(0, fatigue - Config.Fatigue.DecreaseActive)
            lastMove = GetGameTimer()
            if isAFK then
                isAFK = false
                ClearTimecycleModifier()
            end
        else
            fatigue = math.min(Config.Fatigue.Max, fatigue + Config.Fatigue.IncreaseIdle)
        end

        if GetGameTimer() - lastMove > Config.Fatigue.AFKTime * 1000 then
            if not isAFK then
                isAFK = true
                lib.notify({ description = _L('afk'), type = 'warning' })
            end
        end

        if fatigue >= Config.Fatigue.BlurStart then
            local strength = (fatigue / Config.Fatigue.BlurMax)
            SetTimecycleModifier('hud_def_blur')
            SetTimecycleModifierStrength(strength)
        else
            ClearTimecycleModifier()
        end

        SendNUIMessage({
            action = 'update',
            fatigue = fatigue
        })
    end
end)

CreateThread(function()
    while true do
        Wait(Config.SaveInterval * 1000)
        TriggerServerEvent('mt_fatigue:save', fatigue)
    end
end)
