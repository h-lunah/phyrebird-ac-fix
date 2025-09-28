--thanks to StepMod / arka for this, extracted from StepMod 1.2
local function GetStageNumberActor()
	local first_digit;
	local second_digit;
	local stage = STATSMAN:GetStagesPlayed()+1;
	
	if( stage > 99 ) then
		first_digit = 9;
		second_digit = 9;
	else
		first_digit = math.floor(stage/10);
		second_digit = stage - (first_digit*10);
	end;
		
	return Def.ActorFrame {
		LoadActor( THEME:GetPathG("","ScreenGameplay/STAGE_FM") ).. {
			InitCommand=cmd(FromTop,28);
		};
		LoadActor( THEME:GetPathG("","ScreenGameplay/N_FM") ).. {
			InitCommand=cmd(zoom, .5;x,-12;FromTop,34;pause;setstate,first_digit);
		};
		LoadActor( THEME:GetPathG("","ScreenGameplay/N_FM") ).. {
			InitCommand=cmd(zoom, .5;x,12;FromTop,34;pause;setstate,second_digit);
		};
	};
end;



local function PlayerName( Player )
	local t = Def.ActorFrame {
		LoadFont("","_myriad pro 20px") .. {
			Name = "Name";
			InitCommand=cmd(horizalign,left;y,-8;x,-70);
		};
	};
	return t;
end;

local t = Def.ActorFrame {};

local style = GAMESTATE:GetCurrentStyle():GetStyleType();
local pn;
if( GAMESTATE:IsSideJoined(PLAYER_1) ) then pn = PLAYER_1 else pn = PLAYER_2 end;

if( (style=='StyleType_OnePlayerTwoSides') or (style=='StyleType_TwoPlayersSharedSides') ) then
	t[#t+1] = GetStageNumberActor()..{ InitCommand=cmd(basezoom,.67;stoptweening;FromCenterX,-285); };
else
	t[#t+1] = GetStageNumberActor()..{ InitCommand=cmd(basezoom,.67;FromCenterX,0); };
end;


------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function GetPlayerPosition( player )
	local P1PosX = SCREEN_CENTER_X-159;
	local P2PosX = SCREEN_CENTER_X+159;
	
	local style = GAMESTATE:GetCurrentSteps(player):GetStepsType();
	
	if IsUnderAttackForPlayer( player ) then
		if style == 'StepsType_Pump_Single' or style == 'StepsType_Pump_Couple' then
			if player == PLAYER_1 then return P1PosX; else return P2PosX; end;
		else
			return SCREEN_CENTER_X;
		end;
	end;
	
	if style == 'StepsType_Pump_Single' or style == 'StepsType_Pump_Couple' then
		if player == PLAYER_1 then return P1PosX; else return P2PosX; end;
	else
		return SCREEN_CENTER_X;
	end;
end;


-- Song Title --
--[[
local songtitle = GAMESTATE:GetCurrentSong():GetDisplayMainTitle();
local cur_song = GAMESTATE:GetCurrentSong();
local cur_steps = GAMESTATE:GetCurrentSteps(PLAYER_1);
songtitle = string.upper(songtitle);

t[#t+1] = Def.BitmapText {
	Font="_myriad pro 20px",
	Text="♫"..songtitle,
	InitCommand=function(self)
		self:y(SCREEN_BOTTOM-9);
		self:x(SCREEN_CENTER_X);
		self:zoom(.84);
		self:maxwidth(440);
		self:diffuse(color("#ccfffe"));
	end;
};
--]]

return t;