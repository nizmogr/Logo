-----------------------------------------------------------------
-- Logo Watermark- A Simple FiveM Script, Made By Jordan.#2139 --
-----------------------------------------------------------------

----------------------------------------------------------------------------------------------
                  -- !WARNING! !WARNING! !WARNING! !WARNING! !WARNING! --
        -- DO NOT TOUCH THIS FILE OR YOU /WILL/ FUCK SHIT UP! EDIT NOTHING --
-- DO NOT BE STUPID AND WHINE TO ME ABOUT THIS BEING BROKEN IF YOU TOUCHED THE LINES BELOW. --
----------------------------------------------------------------------------------------------
local isUiOpen = false 
local userTurnedOff = false

Citizen.CreateThread(function()
    TriggerEvent("chat:addSuggestion", "/togglewm", "help text", {
      { help='Toggle the watermark' }
    })
    
    return
end)

AddEventHandler('playerSpawned', function (spawn)
  Citizen.CreateThread(function ()
    isUiOpen = true
    TriggerEvent('DisplayWM', true) 
  end)
end)

RegisterNetEvent('DisplayWM', function (status)
  if status then 
    SendNUIMessage({displayWindow = 'true'})
    isUiOpen = true
    userTurnedOff = false
  else
    SendNUIMessage({displayWindow = 'false'})
    isUiOpen = false
    userTurnedOff = true
  end
end)

RegisterCommand('togglewm', function()
  if config.allowoff then
    if not isUiOpen then
      TriggerEvent('DisplayWM', true)
    else
      TriggerEvent('DisplayWM', false) 
    end
  else 
    TriggerEvent('chat:addMessage', {
      color = { 255, 0, 0},
      multiline = false,
      args = {"^9[Logo-WM] ^1This server has disabled the option for you to toggle the watermark!"}
    })    
  end
end)

local IsPaused = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    if IsPauseMenuActive() and not IsPaused then
      IsPaused = true
      TriggerEvent('DisplayWM', false)
    elseif not IsPauseMenuActive() and IsPaused then
      IsPaused = false
      TriggerEvent('DisplayWM', true)
    end
  end
end)
