local show = false
local windDegrees = false
local last_location_str = ""

local zoneTypes = {
    [1] = "town",
    [2] = "lake", 
    [3] = "river",
    [4] = "unknown4",
    [5] = "swamp",  
    [6] = "ocean",
    [7] = "creek", 
    [8] = "pond",
    [9] = "unknown9",
    [10] = "district",
}


local zoneHashes = {
    
        -- Towns [ 1 ]
    ["7359335"] = 'ANNESBURG',
    ["-744494798"] = 'ARMADILLO',
    ["1053078005"] = 'BLACKWATER',
    ["2586580314"] = 'BEECHERSHOPE',
    ["1778899666"] = 'BRAITHWAITE',
    ["2347551651"] = 'BUTCHER',
    ["1862420670"] = 'CALIGA',
    ["2443661614"] = 'CORNWALL',    
    ["-473051294"] = 'EMERALD RANCH', --ADDED
    ["406627834"] = 'LAGRAS',
    ["1463094051"] = 'MANZANITA',
    ["2046780049"] = 'RHODES',
    ["2147354003"] = 'SISKA',
    ["-765540529"] = 'ST DENIS',
    ["427683330"] = 'STRAWBERRY',
    ["459833523"] = 'VALENTINE',
    ["2126321341"] = 'VAN HORN',
    ["3422345262"] = 'WALLACE',
    ["1663398575"] = 'WAPITI',
    ["1654810713"] = 'AGUASDULCESFARM',
    ["201158410"] = 'AGUASDULCESRUINS',
    ["3087833527"] = 'AGUASDULCESVILLA',
    ["1299204683"] = 'MANICATO',
    ["-1524959147"] = 'TUMBLEWEED', -- ADDED

        -- Lake [ 2 ]
    ["-196675805"] = 'AURORA BASIN',
    ["795414694"] = 'BARROW LAGOON',
    ["231313522"] = 'CALMUT RAVINE',
    ["-105598602"] = 'ELYSIAN POOL',
    ["-1356490953"] = 'FLAT IRON LAKE', -- ADDED
    ["1755369577"] = 'HEARTLANDS OVERFLOW',
    ["-1369817450"] = 'LAKE DON JULIO', --ADDED
    ["592454541"] = 'LAKE ISABELLA',
    ["-1817904483"] = 'O`CREAGHS RUN',
    ["-1300497193"] = 'OWANJILA', --ADDED
    ["-247856387"] = 'SEA OF CORONADO', --ADDED

        -- Rivers [ 3 ]
    ["650214731"] = 'BEARTOOTH BECK',
    ["370072007"] = 'DAKOTA RIVER',
    ["-1229593481"] = 'KAMASSA RIVER', --ADDED
    ["-2040708515"] = 'LANNAHECHEE RIVER', --ADDED 
    ["-1410384421"] = 'LITTLE CREEK RIVER',
    ["-1308233316"] = 'LOWER MONTANA RIVER',
    ["-1504425495"] = 'SAN LUIS RIVER', --ADDED
    ["2513836853"] = 'UPPER MONTANA RIVER', --ADDED
    ["-1781130443"] = 'UPPER MONTANA RIVER',
    ["-49694339"] = 'ARROYO DE LA VIBORA',

    -- UNKNOWN [ 4 ]

    -- SWAMPS [ 5 ]
    ["3737676723"] = 'BAYOU NWA',    
    ["-557290573"] = 'LAGRAS', 
    -- Ocean [ 6 ]
    ["-1168459546"] = 'BAHIA DE LA PAZ',

    -- Creeks [ 7 ]
    ["1245451421"] = 'DEADBOOT CREEK',
    ["469159176"] = 'DEWBERRY CREEK',
    ["3018380936"] = 'HAWKS EYE CREEK',
    ["2005774838"] = 'RINGNECK CREEK',
    ["-218679770"] = 'SPIDER GORGE',
    ["-1287619521"] = 'STILLWATER CREEK',
    ["-261541730"] = 'WHINYARD STRAIT',
    ["-1276586360"] = 'HAWKS EYE CREEK',

    -- Ponds [ 8 ]
    ["-1073312073"] = 'CAIRN LAKE',
    ["-804804953"] = 'CATTAIL POND',
    ["1175365009"] = 'COTORRA HOT SPRINGS',
    ["301094150"] = 'MATTOCK POND',
    ["-811730579"] = 'MOONSTONE POND',
    ["-823661292"] = 'SOUTHFIELD FLATS',
    
    -- UNKNOWN [ 9 ]

    -- Districts [ 10 ]
    ["3782438103"] = 'GUARMAD',
    ["2025841068"] = 'BAYOU NWA',
    ["822658194"] = 'BIG VALLEY',
    ["1308232528"] = 'BLUEWATER MARSH',
    ["-108848014"] = 'CHOLLA SPRINGS',
    ["1835499550"] = 'CUMBERLAND FOREST',
    ["426773653"] = 'DIEZCORONAS',
    ["-2066240242"] = 'GAPTOOTH RIDGE',--ADDED
    ["476637847"] = 'GREAT PLAINS',
    ["-120156735"] = 'GRIZZLIES EAST',
    ["1645618177"] = 'GRIZZLIES WEST',
    ["892930832"] = 'HENNIGAN`S STEAD',
    ["2975011176"] = 'PERDIDO',
    ["1453836102"] = 'PUNTAORGULLO',
    ["-2145992129"] = 'RIO BRAVO', --ADDED
    ["178647645"] = 'ROANOKE RIDGE',
    ["-864275692"] = 'SCARLETT MEADOWS',
    ["1684533001"] = 'TALL TREES',
    ["131399519"] = 'THE HEARTLANDS',

    -- States [ NOT USED with 0x43AD8FC02B429D33 ] 
    -- ["4073907364"] = 'AMBARINO',
    -- ["10837344"] = 'LEMOYNE',
    -- ["2045157995"] = 'NEW AUSTIN',
    -- ["3005831075"] = 'NEW HANOVER',
    -- ["613867492"] = 'NUEVO PARAISO',
    -- ["1246494439"] = 'WEST ELIZABETH',
    -- ["2321575796"] = 'LOWER WEST ELIZABETH',
    -- ["3047819085"] = 'UPPER WEST ELIZABETH',
    -- ["1935063277"] = 'GUARMA',

}

-- HELPER FUNCTION: SORT PAIRS BY KEY 
function spairs(t, order)

    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- Return Current Map DATA
function returnMapData(x,y,z)

    local mapdata = {}
    local init = {

        [1] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 1), -- 1: TOWN
        [2] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 2), -- 2: LAKE 
        [3] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 3), -- 3: RIVER
        [4] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 4), -- 4: UNKNOWN
        [5] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 5), -- 5: SWAMP  
        [6] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 6), -- 6: OCEAN 
        [7] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 7), -- 7: CREEK 
        [8] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 8), --8: POND
        [9] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 9), --9: UNKNOWN
        [10] = Citizen.InvokeNative(0x43AD8FC02B429D33, x, y, z, 10), --10: DISTRICT

    }

    for k,v in pairs(init) do
        if v ~= false then
            --- UNCOMMENT TO PRINT UNKNOWN LOCATIONS
            --if not zoneHashes[tostring(v)] then 
                --print("UNKNOWN zoneHash: " .. k .." - ".. v)
            --end    
            mapdata[k] = zoneHashes[tostring(v)]
        end
    end

    return mapdata

end


-- BASIC THREAD
CreateThread( function()
    while true do 
        Wait(1)
        --Hide Default Hud
        HideHudAndRadarThisFrame()
		
		-- this does not exactly work as in Native
		-- GET_GAMEPLAY_CAM_RELATIVE_HEADING ?
		local ped = PlayerPedId()
		local h = GetEntityHeading(ped)        
        h = h + GetGameplayCamRelativeHeading()
        
        -- HEALTH
        local phealth = GetEntityHealth(ped)
        local mhealth = GetEntityMaxHealth(ped,true) 
        local hl = (phealth*100)/mhealth
        
        -- STAMINA
        local pstamina = GetAttributeCoreValue(PlayerPedId(),1)
        local mstamina = 100
        local st = (pstamina*100)/mstamina

        -- TIME
        local hour = GetClockHours()
        local minute = GetClockMinutes()
        local timeText = ("%.2d"):format((hour == 0) and 12 or hour) .. ":" .. ("%.2d"):format( minute) .. ((hour < 12) and " AM" or " PM")
        
        if not windDegrees then 
        -- WIND DIRECTION
            local windCoords = vector3(GetWindDirection())
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            windDegrees = angle(pedCoords,windCoords)
        end
        --print(windDegrees)

        if show then
            SendNUIMessage({ action = "display", heading = h, health = hl, stamina = st, windir = windDegrees+180, time = timeText, location = last_location_str })
        end


    end
end)

-- Update Wind_Direction and Location ( sep thread, save some calculation time )
CreateThread( function()
    while true do 
        Wait(200)
            local windCoords = vector3(GetWindDirection())
            local pedCoords = GetEntityCoords(PlayerPedId())
            --local windCoords = {x=-191.7388,y=563.6989,z=113.7724}   
            windDegrees = angle(pedCoords,windCoords)

            -- LOCATION
            local pCoords = GetEntityCoords(PlayerPedId())
            local mapZone = returnMapData(pCoords.x,pCoords.y,pCoords.z)
            local location_str = ""

        -- SORTED KEYS ! 
        for k,v in spairs(mapZone) do
            local append =  ""
            if next (mapZone) ~= nil and location_str ~= "" then
              append =  " | "
            end
            location_str = location_str .. append .. v
        end

        if location_str ~= last_location_str then
            last_location_str = location_str
        end

    end
end)

-- RETURN ANGLE BETWEEN TWO VECTORS
function angle(vector0, vector1)         
        local dot_product = vector0.x * vector1.x + vector0.y * vector1.y;
        local cross_product = vector0.x * vector1.y + vector0.y * vector1.x;
        
        local vector0_length = math.sqrt(vector0.x * vector0.x + vector0.y * vector0.y);
        local vector1_length = math.sqrt(vector1.x * vector1.x + vector1.y * vector1.y);
        
        local angle= math.acos(dot_product / (vector0_length * vector1_length)) * 180 / math.pi;

        angle = math.atan2(math.abs(cross_product), dot_product) * 180 / math.pi;

        if cross_product > 0 then 
            angle = 360 - angle
        end

        return angle
end

function myDot(a, b)
    return (a[1] * b[1]) + (a[2] * b[2]) + (a[3] * b[3])
end

function myMag(a)
    return math.sqrt((a[1] * a[1]) + (a[2] * a[2]) + (a[3] * a[3]))
end
-- Display Compass 
function showCompass()
    SendNUIMessage({
        action = "ui",
        display = true
    })
    show = true
end

-- Hide Compass
function hideCompass()
    SendNUIMessage({
        action = "ui",
        display = false
    })
    show = false
end

AddEventHandler("playerSpawned", function()
	showCompass()
    show = true
end)

AddEventHandler("redemrp_respawn:respawn", function()
    showCompass()
end)
