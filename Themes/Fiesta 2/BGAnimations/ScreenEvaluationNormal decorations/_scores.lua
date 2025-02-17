local t = Def.ActorFrame {
	GoNextScreenMessageCommand=cmd(playcommand,'Off');
};

local init_pos = 150;
local delta = 19;
local spacing = 1.8;
local zoom_number = .70;
local baseScale = 270;

-- Tick sound
local times = 1;
t[#t+1] = LoadActor(THEME:GetPathS("","Sounds/Tick.mp3"))..{
	OnCommand=cmd(sleep,2;queuecommand,'Play');
	PlayCommand=function(self)
		--SOUND:PlayOnce(THEME:GetPathS("","Sounds/Tick.WAV"));
		self:play();
		times = times + 1;
		if( times < 18 ) then
			self:sleep(.068);
			self:queuecommand('Play');
		end;
	end;
	OffCommand=cmd(stoptweening);
}

t[#t+1] = LoadActor(THEME:GetPathS("","Sounds/HEART_PLUS.mp3"))..{
	OnCommand=cmd(sleep,1.8;queuecommand,'Play');
	PlayCommand=function(self)
		self:play();
	end;
	OffCommand=cmd(stoptweening);
}

-- Scores
if GAMESTATE:IsSideJoined(PLAYER_1) then
	local curstats = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1); 
	local perfects = curstats:GetTapNoteScores('TapNoteScore_W2') + curstats:GetTapNoteScores('TapNoteScore_CheckpointHit');
	local greats = curstats:GetTapNoteScores('TapNoteScore_W3');
	local goods = curstats:GetTapNoteScores('TapNoteScore_W4');
	local bads = curstats:GetTapNoteScores('TapNoteScore_W5');
	local misses = curstats:GetTapNoteScores('TapNoteScore_Miss') + curstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
	local helds = curstats:GetTapNoteScores('TapNoteScore_CheckpointHit');
	local drops = curstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
	local maxcombo = curstats:MaxCombo();
	local stagebreak = curstats:GetReachedLifeZero();
	local pscore = CalcPScore(perfects,greats,goods,bads,misses,maxcombo);
	local pgrade = CalcPGrade(pscore);
	local pgradecolor = (stagebreak and "0.596,0.596,0.592,1") or ColorPGrade(pgrade);
	if not stagebreak and (pscore < 750000) then pgradecolor = "#03CC83"; end;
	local plate = (stagebreak and "") or CalcPlate(greats,goods,bads,misses);
	local platecolor = ColorPlate(plate);
	local displayscore = math.floor(curstats:GetScore()/100);
	if displayscore > 1000000 then displayscore = displayscore - 1000000 end;
	local chartstyle = GAMESTATE:GetCurrentSteps(PLAYER_1):GetChartStyle();
	local processed_meter = GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter();
	if processed_meter == 99 then processed_meter = 15 elseif processed_meter > 28 then processed_meter = 28 elseif processed_meter < 1 then processed_meter = 1 end;
	local current_skill = PROFILEMAN:GetProfile(PLAYER_1):GetWeightPounds();
	local skill = 0;
	if string.find(chartstyle,"ACTIVE") then skill = CalcSkill(perfects,greats,goods,bads,misses,helds,drops,maxcombo,processed_meter) end;
	if skill > current_skill then
		PROFILEMAN:GetProfile(PLAYER_1):SetWeightPounds(skill);
		PROFILEMAN:SaveProfile(PLAYER_1);
	end; 

	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), init_pos+delta*3, 	perfects, 'HorizAlign_Left', 2 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), spacing*1+init_pos+delta*4, curstats:GetTapNoteScores('TapNoteScore_W3'), 'HorizAlign_Left', 2.08 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), spacing*2+init_pos+delta*5, curstats:GetTapNoteScores('TapNoteScore_W4'), 'HorizAlign_Left', 2.16 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), spacing*3+init_pos+delta*6, curstats:GetTapNoteScores('TapNoteScore_W5'), 'HorizAlign_Left', 2.24 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), spacing*4+init_pos+delta*7, misses, 'HorizAlign_Left', 2.32 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), spacing*5+init_pos+delta*8, curstats:MaxCombo(), 'HorizAlign_Left', 2.40 )..{InitCommand=cmd(zoom,zoom_number);};

	--kcal
	local kcal = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetCaloriesBurned()*0.70;
	t[#t+1] = DrawRollingNumberP1( WideScale(106, 293), spacing*6+init_pos+delta*9, math.floor( (kcal - math.floor(kcal))*1000 ), 'HorizAlign_Left', 2.56 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( WideScale(66, 266), spacing*6+init_pos+delta*9, math.floor( kcal ), 'HorizAlign_Left', 2.56 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = LoadFont("_myriad pro 20px")..{ InitCommand=cmd(settext,".";y,spacing*6+init_pos+delta*9;x,WideScale(101, 290);zoom,zoom_number;diffusealpha,0;sleep,2.56;diffusealpha,1); };
	
	--totalScore
	t[#t+1] = DrawRollingNumberP2( SCREEN_CENTER_X-189, init_pos+delta*1.4, displayscore, "HorizAlign_Right",3.5 )..{InitCommand=cmd(zoom,2);};

	--plate
	if plate ~= "" then
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenEvaluation/"..plate..".png") )..{
		InitCommand=cmd(basezoom,.50;y,init_pos+delta*10;x,SCREEN_LEFT-150);
		OnCommand=cmd(zoom,.66;sleep,4.5;linear,.25;x,SCREEN_LEFT+135;linear,.95;x,SCREEN_LEFT+150);
	};
	--[[
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenEvaluation/"..plate..".png") )..{
		InitCommand=cmd(basezoom,.50;blend,'BlendMode_Add';y,init_pos+delta*10;x,SCREEN_LEFT+150,1.33;diffusealpha,0);
		OnCommand=cmd(zoom,.33;diffusealpha,0;sleep,4.2;sleep,.2;diffusealpha,1;decelerate,.35;zoom,1.33;diffusealpha,0);
	};
	]]--
	end;

end;

if GAMESTATE:IsSideJoined(PLAYER_2) then
	local curstats = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2); 
	local perfects = curstats:GetTapNoteScores('TapNoteScore_W2') + curstats:GetTapNoteScores('TapNoteScore_CheckpointHit');
	local greats = curstats:GetTapNoteScores('TapNoteScore_W3');
	local goods = curstats:GetTapNoteScores('TapNoteScore_W4');
	local bads = curstats:GetTapNoteScores('TapNoteScore_W5');
	local misses = curstats:GetTapNoteScores('TapNoteScore_Miss') + curstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
	local helds = curstats:GetTapNoteScores('TapNoteScore_CheckpointHit');
	local drops = curstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
	local maxcombo = curstats:MaxCombo();
	local stagebreak = curstats:GetReachedLifeZero();
	local pscore = CalcPScore(perfects,greats,goods,bads,misses,maxcombo);
	local pgrade = CalcPGrade(pscore);
	local pgradecolor = (stagebreak and "0.596,0.596,0.592,1") or ColorPGrade(pgrade);
	if not stagebreak and (pscore < 750000) then pgradecolor = "#03CC83"; end;
	local plate = (stagebreak and "") or CalcPlate(greats,goods,bads,misses);
	local platecolor = ColorPlate(plate);
	local displayscore = math.floor(curstats:GetScore()/100);
	if displayscore > 1000000 then displayscore = displayscore - 1000000 end;
	local processed_meter = GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter();
	local chartstyle = GAMESTATE:GetCurrentSteps(PLAYER_2):GetChartStyle();
	if processed_meter == 99 then processed_meter = 15 elseif processed_meter > 28 then processed_meter = 28 elseif processed_meter < 1 then processed_meter = 1 end;
	local skill = 0;
	if string.find(chartstyle,"ACTIVE") then skill = CalcSkill(perfects,greats,goods,bads,misses,helds,drops,maxcombo,processed_meter) end;
	local current_skill = PROFILEMAN:GetProfile(PLAYER_2):GetWeightPounds();
	if skill > current_skill then
		PROFILEMAN:GetProfile(PLAYER_2):SetWeightPounds(skill);
		PROFILEMAN:SaveProfile(PLAYER_2);
	end; 
	
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 266), init_pos+delta*3, 	perfects, 'HorizAlign_Right', 2 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 266), spacing*1+init_pos+delta*4, greats, 'HorizAlign_Right', 2.08 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 266), spacing*2+init_pos+delta*5, goods, 'HorizAlign_Right', 2.16 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 266), spacing*3+init_pos+delta*6, bads, 'HorizAlign_Right', 2.24 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 266), spacing*4+init_pos+delta*7, misses, 'HorizAlign_Right', 2.32 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 266), spacing*5+init_pos+delta*8, maxcombo, 'HorizAlign_Right', 2.40 )..{InitCommand=cmd(zoom,zoom_number);};

	--kcal
	local kcal = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2):GetCaloriesBurned()*0.70;
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(106, 266), spacing*6+init_pos+delta*9, math.floor( (kcal - math.floor(kcal))*1000 ), 'HorizAlign_Right', 2.56 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = DrawRollingNumberP1( SCREEN_RIGHT-WideScale(66, 293), spacing*6+init_pos+delta*9, math.floor( kcal ), 'HorizAlign_Right', 2.56 )..{InitCommand=cmd(zoom,zoom_number);};
	t[#t+1] = LoadFont("_myriad pro 20px")..{ InitCommand=cmd(settext,".";y,spacing*6+init_pos+delta*9;x,SCREEN_RIGHT-WideScale(101, 290);zoom,zoom_number;diffusealpha,0;sleep,2.56;diffusealpha,1); };

	--totalScore
	t[#t+1] = DrawRollingNumberP2( SCREEN_CENTER_X+372, init_pos+delta*1.4, displayscore, "HorizAlign_Right", 3.5 )..{InitCommand=cmd(zoom,2);};

	--plate
	if plate ~= "" then
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenEvaluation/"..plate..".png") )..{
		InitCommand=cmd(basezoom,.50;y,init_pos+delta*10;x,SCREEN_RIGHT+150);
		OnCommand=cmd(zoom,.66;sleep,4.5;linear,.25;x,SCREEN_RIGHT-135;linear,.95;x,SCREEN_RIGHT-150);
	};
	--[[t[#t+1] = LoadActor( THEME:GetPathG("","ScreenEvaluation/"..plate..".png") )..{
		InitCommand=cmd(basezoom,.50;blend,'BlendMode_Add';y,init_pos+delta*10;x,SCREEN_RIGHT-150);
		OnCommand=cmd(zoom,.33;diffusealpha,0;sleep,4.2;sleep,.2;diffusealpha,1;decelerate,.35;zoom,1.33;diffusealpha,0);
	};]]--
	end;

end;

return t;