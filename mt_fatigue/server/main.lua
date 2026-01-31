local isESX = GetResourceState('es_extended') == 'started'

RegisterNetEvent('mt_fatigue:save', function(value)
    local src = source

    if isESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            MySQL.update(
                'UPDATE users SET fatigue = ? WHERE identifier = ?',
                { value, xPlayer.identifier }
            )
        end
    else
        local file = LoadResourceFile(GetCurrentResourceName(), 'data.json')
        local data = file and json.decode(file) or {}
        data[tostring(src)] = value
        SaveResourceFile(GetCurrentResourceName(), 'data.json', json.encode(data), -1)
    end
end)
