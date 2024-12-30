local player = ...

local steps = GAMESTATE:GetCurrentSteps(player)
local hash = ""
local difficulty = ""

if steps then
    hash = tostring(steps:GetHash()):sub(1, 12)
    
	difficulty = tostring(steps:GetMeter())
end

local curstats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
local perfects = curstats:GetTapNoteScores('TapNoteScore_W2') + curstats:GetTapNoteScores('TapNoteScore_CheckpointHit');
local greats = curstats:GetTapNoteScores('TapNoteScore_W3');
local goods = curstats:GetTapNoteScores('TapNoteScore_W4');
local bads = curstats:GetTapNoteScores('TapNoteScore_W5');
local misses = curstats:GetTapNoteScores('TapNoteScore_Miss') + curstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
local maxcombo = curstats:MaxCombo();
local score = tostring(CalcPScore(perfects,greats,goods,bads,misses,maxcombo));
local plate = tostring(CalcPlateInitials(greats,goods,bads,misses));
local stagebreak = curstats:GetReachedLifeZero() and "1" or "0";

local finalurl = ("https://piuscores.com/qr.php?h=%s&l=%s&s=%s&p=%s&b=%s"):format(hash, difficulty, score, plate, stagebreak)

return finalurl
