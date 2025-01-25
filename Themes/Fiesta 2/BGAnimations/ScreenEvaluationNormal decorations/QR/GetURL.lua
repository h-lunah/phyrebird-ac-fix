local player = ...

local steps = GAMESTATE:GetCurrentSteps(player)
local hash = ""
local difficulty = ""
local songtitle = ""

if steps then
    hash = tostring(steps:GetHash()):sub(1, 12)
    songtitle = GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
    songtitle = urlencode(songtitle)
    local style = GAMESTATE:GetCurrentSteps(player):GetStepsType();
    local style_letter = "c"
    if style=='StepsType_Pump_Single' then style_letter = "s";
	elseif style=='StepsType_Pump_Halfdouble' then style_letter = "d";
	elseif style=='StepsType_Pump_Double' then style_letter = "d";
	end;
	difficulty = style_letter..tostring(steps:GetMeter())
end

local curstats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
local perfects = curstats:GetTapNoteScores('TapNoteScore_W2') + curstats:GetTapNoteScores('TapNoteScore_CheckpointHit');
local greats = curstats:GetTapNoteScores('TapNoteScore_W3');
local goods = curstats:GetTapNoteScores('TapNoteScore_W4');
local bads = curstats:GetTapNoteScores('TapNoteScore_W5');
local misses = curstats:GetTapNoteScores('TapNoteScore_Miss') + curstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
local maxcombo = curstats:MaxCombo();
local score = CalcPScore(perfects,greats,goods,bads,misses,maxcombo);
local grade = CalcPGrade(score)
local plate = tostring(CalcPlateInitials(greats,goods,bads,misses));
score = tostring(score);
grade = string.lower(grade);
plate = string.lower(plate);
local stagebreak = curstats:GetReachedLifeZero() and "1" or "0";

local finalurl = ("https://docs.google.com/forms/d/e/placeholderurl/viewform?usp=pp_url&entry.placeholderID=\"%s\";%s;%s;%s;%s"):format(songtitle, difficulty, score, grade, plate)
return finalurl
