local LOW_SHAKE_SPEED = 5.0
local MEDIUM_SHAKE_SPEED = 30.0
local HIGH_SHAKE_SPEED = 80.0
local LOW_SHAKE_INTENSITY = 0.2
local MEDIUM_SHAKE_INTENSITY = 0.5
local HIGH_SHAKE_INTENSITY = 1.0

local function mpsToKmh(speed)
    return speed * 3.6
end

Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if HasEntityCollidedWithAnything(vehicle) then

                local speed = mpsToKmh(GetEntitySpeed(vehicle))

                local shakeIntensity = 0.0
                if speed >= LOW_SHAKE_SPEED and speed < MEDIUM_SHAKE_SPEED then
                    shakeIntensity = LOW_SHAKE_INTENSITY
                elseif speed >= MEDIUM_SHAKE_SPEED and speed < HIGH_SHAKE_SPEED then
                    shakeIntensity = MEDIUM_SHAKE_INTENSITY
                elseif speed >= HIGH_SHAKE_SPEED then
                    shakeIntensity = HIGH_SHAKE_INTENSITY
                end

                if shakeIntensity > 0 then
                    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", shakeIntensity)
                end
                Citizen.Wait(500)
            end
        end
        Citizen.Wait(0)
    end
end)