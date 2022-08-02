ESX = exports['es_extended']:getSharedObject()

local sbelt = false
local inveh
local freq = 0
local forbidden = {
    8,
    13,
}

local zoneNames = {
    AIRP = "Los Santos International Airport",
    ALAMO = "Alamo Sea",
    ALTA = "Alta",
    ARMYB = "Fort Zancudo",
    BANHAMC = "Banham Canyon Dr",
    BANNING = "Banning",
    BAYTRE = "Baytree Canyon",
    BEACH = "Vespucci Beach",
    BHAMCA = "Banham Canyon",
    BRADP = "Braddock Pass",
    BRADT = "Braddock Tunnel",
    BURTON = "Burton",
    CALAFB = "Calafia Bridge",
    CANNY = "Raton Canyon",
    CCREAK = "Cassidy Creek",
    CHAMH = "Chamberlain Hills",
    CHIL = "Vinewood Hills",
    CHU = "Chumash",
    CMSW = "Chiliad Mountain State Wilderness",
    CYPRE = "Cypress Flats",
    DAVIS = "Davis",
    DELBE = "Del Perro Beach",
    DELPE = "Del Perro",
    DELSOL = "La Puerta",
    DESRT = "Grand Senora Desert",
    DOWNT = "Downtown",
    DTVINE = "Downtown Vinewood",
    EAST_V = "East Vinewood",
    EBURO = "El Burro Heights",
    ELGORL = "El Gordo Lighthouse",
    ELYSIAN = "Elysian Island",
    GALFISH = "Galilee",
    GALLI = "Galileo Park",
    golf = "GWC and Golfing Society",
    GRAPES = "Grapeseed",
    GREATC = "Great Chaparral",
    HARMO = "Harmony",
    HAWICK = "Hawick",
    HORS = "Vinewood Racetrack",
    HUMLAB = "Humane Labs and Research",
    JAIL = "Bolingbroke Penitentiary",
    KOREAT = "Little Seoul",
    LACT = "Land Act Reservoir",
    LAGO = "Lago Zancudo",
    LDAM = "Land Act Dam",
    LEGSQU = "Legion Square",
    LMESA = "La Mesa",
    LOSPUER = "La Puerta",
    MIRR = "Mirror Park",
    MORN = "Morningwood",
    MOVIE = "Richards Majestic",
    MTCHIL = "Mount Chiliad",
    MTGORDO = "Mount Gordo",
    MTJOSE = "Mount Josiah",
    MURRI = "Murrieta Heights",
    NCHU = "North Chumash",
    NOOSE = "N.O.O.S.E",
    OCEANA = "Pacific Ocean",
    PALCOV = "Paleto Cove",
    PALETO = "Paleto Bay",
    PALFOR = "Paleto Forest",
    PALHIGH = "Palomino Highlands",
    PALMPOW = "Palmer-Taylor Power Station",
    PBLUFF = "Pacific Bluffs",
    PBOX = "Pillbox Hill",
    PROCOB = "Procopio Beach",
    RANCHO = "Rancho",
    RGLEN = "Richman Glen",
    RICHM = "Richman",
    ROCKF = "Rockford Hills",
    RTRAK = "Redwood Lights Track",
    SanAnd = "San Andreas",
    SANCHIA = "San Chianski Mountain Range",
    SANDY = "Sandy Shores",
    SKID = "Mission Row",
    SLAB = "Stab City",
    STAD = "Maze Bank Arena",
    STRAW = "Strawberry",
    TATAMO = "Tataviam Mountains",
    TERMINA = "Terminal",
    TEXTI = "Textile City",
    TONGVAH = "Tongva Hills",
    TONGVAV = "Tongva Valley",
    VCANA = "Vespucci Canals",
    VESP = "Vespucci",
    VINE = "Vinewood",
    WINDF = "Ron Alternates Wind Farm",
    WVINE = "West Vinewood",
    ZANCUDO = "Zancudo River",
    ZP_ORT = "Port of South Los Santos",
    ZQ_UAR = "Davis Quartz"
}
enabled = false
RegisterCommand('tsbelt', function()
    local class = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false))
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        if not sbelt and not checkclass() then
            sbelt = true
        elseif sbelt then
            sbelt = false 
        elseif checkclass() then
            ESX.ShowNotification('No puedes usar el cinturon en este vehiculo.')
        end
    end
end)

function checkclass()
    local class = GetVehicleClass(GetVehiclePedIsIn(PlayerPedId(), false))
    if class == 8 or class == 13 then
        return true
    else
        return false
    end
end

RegisterKeyMapping('tsbelt', 'Ponerse/quitarse el cinto', 'keyboard', 'B')

function GetStreetNames(coords)
    if coords and type(coords) == 'vector3' then
        local street = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local street1 = GetStreetNameFromHashKey(street)
        local zone = tostring(GetNameOfZone(coords.x, coords.y, coords.z))
        local street2 = zoneNames[tostring(zone)]
        return {street1 = street1, street2 = street2}
    else
        print('dispatch - error 468511')
    end
end

local radioen = false

CreateThread(function()
    while true do
        if freq > 0 then
            radioen = true
        else
            radioen = false
        end
        Wait(1000)
    end
end)

RegisterNetEvent('rsx_ui:setradiochan', function(channel, bool)
    print('setradiochan', channel, bool)
    freq = channel
    local c = GetEntityCoords(PlayerPedId())
    local streetnames = GetStreetNames(c) or 'unknown'
    SendNUIMessage({
        food = hunger,
        water = thirst,
        o2 = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
        health = (GetEntityHealth(PlayerPedId()) -100),
        stamina = GetPlayerSprintTimeRemaining(PlayerPedId()),
        shield = GetPedArmour(PlayerPedId()),
        inveh = inveh,
        sbl = sbelt,
        temp = not inveh or GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)) / 10,
        speed = not inveh or ((GetEntitySpeed(PlayerPedId())) * 3.6),
        gas = not inveh or GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)),
        calles = streetnames.street1..' de '..streetnames.street2,
        istalking = MumbleIsPlayerTalking(PlayerId()),
        range = rango,
        radio = radioen,
        radiochan = freq,
    })
end)

RegisterNetEvent('rsx_ui:showrange', function(rango)
    local c = GetEntityCoords(PlayerPedId())
    local streetnames = GetStreetNames(c) or 'unknown'
    SendNUIMessage({
        food = hunger,
        water = thirst,
        o2 = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
        health = (GetEntityHealth(PlayerPedId()) -100),
        stamina = GetPlayerSprintTimeRemaining(PlayerPedId()),
        shield = GetPedArmour(PlayerPedId()),
        inveh = inveh,
        sbl = sbelt,
        temp = not inveh or GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)) / 10,
        speed = not inveh or ((GetEntitySpeed(PlayerPedId())) * 3.6),
        gas = not inveh or GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)),
        calles = streetnames.street1..' de '..streetnames.street2,
        istalking = MumbleIsPlayerTalking(PlayerId()),
        showrange = 'trigger',
        range = rango,
        radio = radioen,
        radiochan = freq,
    })
end)

RegisterNetEvent('rsx_ui:talkingradio', function(bool)
    local c = GetEntityCoords(PlayerPedId())
    local streetnames = GetStreetNames(c) or 'unknown'
    talkingradio = bool
    SendNUIMessage({
        food = hunger,
        water = thirst,
        o2 = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
        health = (GetEntityHealth(PlayerPedId()) -100),
        stamina = GetPlayerSprintTimeRemaining(PlayerPedId()),
        shield = GetPedArmour(PlayerPedId()),
        inveh = inveh,
        sbl = sbelt,
        temp = not inveh or GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)) / 10,
        speed = not inveh or ((GetEntitySpeed(PlayerPedId())) * 3.6),
        gas = not inveh or GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)),
        calles = streetnames.street1..' de '..streetnames.street2,
        istalking = MumbleIsPlayerTalking(PlayerId()),
        range = rango,
        radiochan = freq,
        talkingradio = talkingradio,
        radio = radioen
    })
end)

CreateThread(function()
    while true do
        local _sleep = 800
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.val / 10000
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.val / 10000
        end)
        local c = GetEntityCoords(PlayerPedId())
        local streetnames = GetStreetNames(c) or 'unknown'
        SendNUIMessage({
            food = hunger,
            water = thirst,
            o2 = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10,
            health = (GetEntityHealth(PlayerPedId()) -100),
            stamina = GetPlayerSprintTimeRemaining(PlayerPedId()),
            shield = GetPedArmour(PlayerPedId()),
            inveh = inveh,
            sbl = sbelt,
            temp = not inveh or GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)) / 10,
            speed = not inveh or ((GetEntitySpeed(PlayerPedId())) * 3.6),
            gas = not inveh or GetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(), false)),
            calles = streetnames.street1..' de '..streetnames.street2,
            istalking = MumbleIsPlayerTalking(PlayerId()),
            range = rango,
            radiochan = freq,
            talkingradio = talkingradio,
            radio = radioen
        })

        if IsPedInAnyVehicle(PlayerPedId()) then
            _sleep = 100
            inveh = true
            DisplayRadar(true)
        else
            sbelt = false
            DisplayRadar(false)
            inveh = false
            enabled = false
        end
        Wait(_sleep)
    end
end)

CreateThread(function()
    while true do 
        local _sleep = 1000
        if sbelt then
            _sleep = 0
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
        else
            _sleep = 1000
        end
        Wait(_sleep)
    end
end)