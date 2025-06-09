--[[
local player = ...

local po = GAMESTATE:GetPlayerState(player):GetPlayerOptions("ModsLevel_Preferred")
local valid = (po:FailSetting() == "FailType_Immediate" or po:FailSetting() == "FailType_ImmediateContinue")

return valid
]]

return true
