--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
local aSteps = {};
local numSteps;

local iChartsToShow = 13;
local bIsExtensiveList = false;
local zoom_factor = 0.66;

--[[
if PREFSMAN:GetPreference("ExtendedStepsList") then
	iChartsToShow = 14;
end;]]--

local curLimInferior = 1;
local curLimSuperior = iChartsToShow;

local t = Def.ActorFrame {
	InitCommand=cmd(draworder,99;zoom,zoom_factor);
	PlayableStepsChangedMessageCommand=function(self)
		if GAMESTATE:IsBasicMode() then return; end;
		aSteps = nil;
		aSteps = SCREENMAN:GetTopScreen():GetPlayableSteps();
		numSteps = #aSteps;
		
		----
		curLimInferior = 1;
		curLimSuperior = iChartsToShow;
		----
		
		if( numSteps > iChartsToShow ) then
			bIsExtensiveList = true;
		else
			bIsExtensiveList = false;
		end;
		---
		
		self:playcommand('UpDate');
	end;
	ChangeStepsMessageCommand=function(self,params)  --solo ocurre en SelectStepsState
		if GAMESTATE:IsBasicMode() then return; end;
		
		----
		if( bIsExtensiveList ) then -- posiblemente se pase a la siguiente hoja de pasos
				local limInf = 1;
				local limSup = iChartsToShow;
				local pos = SCREENMAN:GetTopScreen():GetSelection(params.Player)+1;
				
				local bAnyChange = false;
				
				if pos > curLimInferior or pos < curLimSuperior then
					bAnyChange = true;
				end;
				
				while (limInf>pos) or (limSup<pos)  do
					bAnyChange = true;
					limInf = limInf + iChartsToShow;
					limSup = limSup + iChartsToShow;
				end;
				
				if bAnyChange then
					if limInf == curLimInferior and limSup == curLimSuperior then
						bAnyChange = false;
					else
						curLimInferior = limInf;
						curLimSuperior = limSup;
					end;
				end;
				
				if bAnyChange then				
					local tempSteps = {};
					tempSteps = SCREENMAN:GetTopScreen():GetPlayableSteps();
					aSteps = nil;
					aSteps = {};
					for j=1,iChartsToShow do
						aSteps[j] = tempSteps[j+limInf-1];
					end;
					
					numSteps = #aSteps;
					self:playcommand('UpDate');
				end;
		end;
		
		self:playcommand('UpDateCursor',{Player = params.Player});
	end;
	--OffCommand=cmd(playcommand,'FadeOut');
}

--////////////////////////////////////////////////////////
-- Regresa un n�mero seg�n el estilo de los pasos "i"
local function GetDiffNum(i)
	--No regresa ningun step
	if i > numSteps then return 4; end;
	
	local style = aSteps[i]:GetStepsType();
	local description = aSteps[i]:GetDescription();
	local meter = aSteps[i]:GetMeter();

	--Clasificacion de pasos x estilo, single, double, couple o halfdouble
	--TODO: "StepsType_Pump_Couple"
	
	if style=='StepsType_Pump_Single' and string.find( description,"SP" ) then return 2;
	elseif style=='StepsType_Pump_Single' then return 0;
	elseif style=='StepsType_Pump_Routine' or (not (string.find(description, "RANDOMSONGS")) and style=='StepsType_Pump_Double' and ((meter == (99 or 50)) or string.find(string.upper(description),"COOP") or string.find(string.upper(description),"CO-OP") or string.find(string.upper(description),"ROUTINE") ) ) then return 6;
	elseif ( style=='StepsType_Pump_Double' and string.find( string.upper(description),"DP" ) ) or style=='StepsType_Pump_Couple' then return 3;
	elseif style=='StepsType_Pump_Halfdouble' then return 1;
	elseif style=='StepsType_Pump_Double' then return 1;
	end;
	
	return 4;
end;

--////////////////////////////////////////////////////////
-- ActorFunction: Setea el meter, i=indice
function Actor:SetMeterValue(i,style)
	if i > numSteps then self:settext(""); return; end;

	if GetDiffNum(i) ~= style then
		self:settext("");
		return;
	end;
	
	local num = aSteps[i]:GetMeter();
	local description = aSteps[i]:GetDescription();
	local chartname = aSteps[i]:GetChartName();
	local chartcredits = aSteps[i]:GetAuthorCredit();
	local style = aSteps[i]:GetStepsType();
	if num > 99 then self:settext("??"); return; end;
	if style=='StepsType_Pump_Routine' or (not (string.find(description, "RANDOMSONGS")) and style=='StepsType_Pump_Double' and ((num == (99 or 50)) or string.find(string.upper(description),"COOP") or string.find(string.upper(description),"CO-OP") or string.find(string.upper(description),"ROUTINE") ) ) then
		local coop_players = "?";
		if string.find(string.upper(description), "2P") or string.find(string.upper(chartname), "2P") or string.find(string.upper(chartcredits), "2 PLAYERS")  or string.find(string.upper(description), "2 P") or string.find(string.upper(chartname), "2 P") or string.find(string.upper(description), "TWO P") or string.find(string.upper(chartname), "TWO P") then coop_players = "2"
		elseif string.find(string.upper(description), "3P") or string.find(string.upper(chartname), "3P") or string.find(string.upper(chartcredits), "3 PLAYERS")  or string.find(string.upper(description), "3 P") or string.find(string.upper(chartname), "3 P") or string.find(string.upper(description), "THREE P") or string.find(string.upper(chartname), "THREE P") then coop_players = "3"
		elseif string.find(string.upper(description), "4P") or string.find(string.upper(chartname), "4P") or string.find(string.upper(chartcredits), "4 PLAYERS")  or string.find(string.upper(description), "4 P") or string.find(string.upper(chartname), "4 P") or string.find(string.upper(description), "FOUR P") or string.find(string.upper(chartname), "FOUR P") then coop_players = "4"
		elseif string.find(string.upper(description), "5P") or string.find(string.upper(chartname), "5P") or string.find(string.upper(chartcredits), "5 PLAYERS")  or string.find(string.upper(description), "5 P") or string.find(string.upper(chartname), "5 P") or string.find(string.upper(description), "FIVE P") or string.find(string.upper(chartname), "FIVE P") then coop_players = "5"
		elseif string.find(string.upper(description), "6P") or string.find(string.upper(chartname), "6P") or string.find(string.upper(chartcredits), "6 PLAYERS")  or string.find(string.upper(description), "6 P") or string.find(string.upper(chartname), "6 P") or string.find(string.upper(description), "SIX P") or string.find(string.upper(chartname), "SIX P") then coop_players = "6"
		elseif string.find(string.upper(description), "7P") or string.find(string.upper(chartname), "7P") or string.find(string.upper(chartcredits), "7 PLAYERS")  or string.find(string.upper(description), "7 P") or string.find(string.upper(chartname), "7 P") or string.find(string.upper(description), "SEVEN P") or string.find(string.upper(chartname), "SEVEN P") then coop_players = "7"
		elseif string.find(string.upper(description), "8P") or string.find(string.upper(chartname), "8P") or string.find(string.upper(chartcredits), "8 PLAYERS")  or string.find(string.upper(description), "8 P") or string.find(string.upper(chartname), "8 P") or string.find(string.upper(description), "EIGHT P") or string.find(string.upper(chartname), "EIGHT P") then coop_players = "8"
		elseif string.find(string.upper(description), "9P") or string.find(string.upper(chartname), "9P") or string.find(string.upper(chartcredits), "9 PLAYERS")  or string.find(string.upper(description), "9 P") or string.find(string.upper(chartname), "9 P") or string.find(string.upper(description), "NINE P") or string.find(string.upper(chartname), "NINE P") then coop_players = "9"
		elseif string.find(string.upper(description), "1P") or string.find(string.upper(chartname), "1P") or string.find(string.upper(chartcredits), "1 PLAYER")  or string.find(string.upper(description), "1 P") or string.find(string.upper(chartname), "1 P") or string.find(string.upper(description), "ONE P") or string.find(string.upper(chartname), "ONE P") then coop_players = "1"
		end;
		self:settext("X"..coop_players); return;
	elseif num == 99 then self:settext("??"); return;
	end;
	if num == -1 then self:settext("!!"); return; end;
	
	self:settext( string.format("%.2d",num) );
end;


--////////////////////////////////////////////////////////
local function GetSmallBallLabel( i )
	if i > numSteps then return GetLabelNumber(""); end;	--empty
	if string.find(aSteps[i]:GetDescription(),"TITLE") then
		return 10
	else
		return GetLabelNumber( aSteps[i]:GetLabel() );
	end
end;

local function GetUnderBallLabel( i )
	if i > numSteps then return 2; end;	--empty
	local cur_step = aSteps[i];

	local style = cur_step:GetStepsType();
	local description = cur_step:GetDescription();
	
	if ( style=='StepsType_Pump_Double' and string.find( string.upper(description),"HALFDOUBLE" ) ) or style=='StepsType_Pump_Halfdouble' then
		return 0;
	elseif ( style=='StepsType_Pump_Couple' ) then
		return 1
	end;
	
	return 2;
end;

local function GetActiveBallLabel( i )
	if i > numSteps then return 0; end;	--empty
	local cur_step = aSteps[i];
	local chartstyle = cur_step:GetChartStyle();
	if string.find(chartstyle,"ACTIVE") then
		return 1;
	end;
	return 0;
end;

--////////////////////////////////////////////////////////
--Regresa el indice que esta activo.
local function GetActiveIndex(pn)
	if not GAMESTATE:IsSideJoined(pn) then return nil; end;
	
	local selection = SCREENMAN:GetTopScreen():GetSelection(pn)+1;
	local index = selection;
	
	while index > iChartsToShow do
		index = index - iChartsToShow;
	end;
	
	return index;
end;

--[[
function IsNewStepByGroupCondition()
	local cur_song = GAMESTATE:GetCurrentSong();
	if not getenv("IsNewFor"..cur_song:GetGroupName().."Group") then
		return false;
	end;
	return true;
end;
]]--

local function GetPersonalGrade(pn, i)
	if GAMESTATE:IsSideJoined(pn) and GAMESTATE:HasProfile(pn) and aSteps[i] then
		local HighScores = PROFILEMAN:GetProfile(pn):GetHighScoreList(GAMESTATE:GetCurrentSong(), aSteps[i]):GetHighScores()
		if #HighScores ~= 0 then
			local BestScore = math.floor(HighScores[1]:GetScore()/100);
			local StagePass = "B_";
			if BestScore > 2000000 then 
				return nil 
			end
			if BestScore > 1000000 then
				BestScore = BestScore - 1000000;
				StagePass = "R_";
			end;
			local Grade = CalcPGrade(BestScore);
			return StagePass..Grade
		else
			return nil
		end
	else
		return nil
	end
end

--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


--BackDiffList
--[[t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/fullbar_black") ).. {
	InitCommand=cmd(y,250; zoom,1.5;);
};]]

local Xqt = 13
local Yposit = 250
for i=1, Xqt do
	local Xposit = -220-377.8+(i-1)*100
	local YY = 0
		if i == 1 then 
			YY = 0
		end
		if i == 2 then
			YY = -5
		end
		if i == 3 then 
			YY = -10
		end
		if i > 3 and i < 11 then
			YY = -15
		end
		if i == 11 then
			YY = -10
		end
		if i == 12 then
			YY = -5
		end
		if i == 13 then
			YY = 0
		end
			
			t[#t+1] = LoadActor(THEME:GetPathG("", "ScreenSelectMusic/blackball")).. {
				InitCommand=cmd(x,Xposit;y,YY;zoom,1.5);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
			};

			t[#t+1] = LoadActor(THEME:GetPathG("","ScreenSelectMusic/fullbar balls 7x1.png") ) .. {
				InitCommand=cmd(x,Xposit;y,YY;zoom,1.7;pause);
				UpDateCommand=cmd( setstate,GetDiffNum(i);visible,GetDiffNum(i)~=4 );
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
			}
			t[#t+1] = LoadActor(THEME:GetPathG("","ScreenSelectMusic/active.png") ) .. {
				InitCommand=cmd(x,Xposit;y,YY;zoom,1.5;diffusealpha,0);
				UpDateCommand=cmd( diffusealpha,GetActiveBallLabel(i); glowshift );
			};	

			t[#t+1] = LoadFont("N_SINGLE_N") .. {
				InitCommand=cmd(x,Xposit;y,YY-1.1;zoom,1.6);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( SetMeterValue,i,0 );
			};
			
			t[#t+1] = LoadFont("N_SINGLE_P") .. {
				InitCommand=cmd(x,Xposit;y,YY-1.1;zoom,1.6);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( SetMeterValue,i,2 );
			};
			
			t[#t+1] = LoadFont("N_DOUBLE_N") .. {
				InitCommand=cmd(x,Xposit;y,YY-1.1;zoom,1.6);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( SetMeterValue,i,1 );
			};
			
			t[#t+1] = LoadFont("N_DOUBLE_P") .. {
				InitCommand=cmd(x,Xposit;y,YY-1.1;zoom,1.6);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( SetMeterValue,i,3 );
			};
		
			t[#t+1] = LoadFont("N_DOUBLE_N") .. {
				InitCommand=cmd(x,Xposit;y,YY-1.1;zoom,1.6);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( SetMeterValue,i,5 );
			};
		
			t[#t+1] = LoadFont("N_COOP") .. {
				InitCommand=cmd(x,Xposit;y,YY-1.1;zoom,1.6);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( SetMeterValue,i,6 );
			};
			
			-- Labels --
			t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/B_LABELS 1x12.png") ) .. {
				InitCommand=cmd(x,Xposit;pause;y,YY-25;zoom,.55);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i];linear,.3;y,21);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i];linear,.3;y,22);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY-25;sleep,.1;linear,.3;);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY-25);
				UpDateCommand=cmd( setstate,GetSmallBallLabel(i) );
			};

			--[[ Verificar depopis?!
			-- Labels --
			t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/B_LABELS 1x12.png") ) .. {
				InitCommand=cmd(x,Xposit;pause;y,YY-22;zoom,.55);
				StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i];linear,.3;y,250-21);
				GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i];linear,.3;y,250-22);
				StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY;sleep,.1;linear,.3;y,0);
				GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
				UpDateCommand=cmd( setstate,GetSmallBallLabel(i) );
			};
]]
	-- Top Rank
	t[#t+1] = Def.Sprite {
		Name="RankP1";
		Texture=THEME:GetPathG("", "RecordGrades/R_F (doubleres).png");
		InitCommand=cmd(x,Xposit;y,-50;zoom,0.65);
		StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY-50;sleep,.1;linear,.3;y,-50);
		GoBackSelectingSongMessageCommand=cmd(stoptweening;y,-50;sleep,.1;linear,.3;y,YY-50);
		UpDateCommand=function(self)
			local Grade = GetPersonalGrade(PLAYER_1, i)
			if Grade ~= nil then
				self:Load(THEME:GetPathG("", "RecordGrades/" .. Grade .. " (doubleres).png"))
			else
				self:Load(nil)
			end
		end;
	};
	
	-- Bottom Rank
	t[#t+1] = Def.Sprite {
		Name="RankP2";
		Texture=THEME:GetPathG("", "RecordGrades/R_F (doubleres).png");
		InitCommand=cmd(x,Xposit;y,YY+50;zoom,0.65);
		StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY+50;sleep,.1;linear,.3;y,50);
		GoBackSelectingSongMessageCommand=cmd(stoptweening;y,50;sleep,.1;linear,.3;y,YY+50);
		UpDateCommand=function(self)
			local Grade = GetPersonalGrade(PLAYER_2, i)
			if Grade ~= nil then
				self:Load(THEME:GetPathG("", "RecordGrades/" .. Grade .. " (doubleres).png"))
			else
				self:Load(nil)
			end
		end;
	};
	
	-- Under Labels --
	t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/B_UNDERLABELS 1x3") ).. {

		InitCommand=cmd(x,Xposit;pause;y,YY+19;zoom,.5);
		StartSelectingStepsMessageCommand=cmd(stoptweening;diffusealpha,1;y,YY-22;sleep,.1;linear,.3;y,0);
		GoBackSelectingSongMessageCommand=cmd(stoptweening;y,0;sleep,.1;linear,.3;y,YY);
		UpDateCommand=cmd( setstate,GetUnderBallLabel(i) );
	};
	
end

------------------------------------------------
-- Cursor Function --
local Xpos = {}
for i=1,iChartsToShow do
	Xpos[i] = -220-377.8+(i-1)*100;
	local YY = 0
		if i == 1 then 
			YY = 0
		end
		if i == 2 then
			YY = -5
		end
		if i == 3 then 
			YY = -10
		end
		if i > 3 and i < 11 then
			YY = -15
		end
		if i == 11 then
			YY = -10
		end
		if i == 12 then
			YY = -5
		end
		if i == 13 then
			YY = 0
		end
end


local function GetCursorFor(pn)
	if GAMESTATE:IsSideJoined(pn) or ( not GAMESTATE:IsSideJoined(pn) and GAMESTATE:IsBasicMode() ) then
		local a = Def.ActorFrame {
			InitCommand=function(self)
				if not GAMESTATE:IsSideJoined(pn) then
					self:visible(false);
				end;
			end;
			PlayerJoinedMessageCommand=function(self,params)
				if params.Player == pn then
					self:visible(true);
				end;
			end;
		};
		--
		a[#a+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/fullbar_"..pn.."_cursor") )..{
			InitCommand=cmd(zoom, 2);
			OnCommand=cmd(stoptweening;diffusealpha,0);
			StartSelectingStepsMessageCommand=function(self)
				if not GAMESTATE:IsSideJoined(pn) then return; end;
				(cmd(zoom, 2;stoptweening;x,Xpos[GetActiveIndex(pn)];diffusealpha,0;zoom,2;sleep,.25;linear,.05;diffusealpha,1;queuecommand,'Loop'))(self);
			end;
			UpDateCursorCommand=function(self,params)
				if params.Player ~= pn then return; end;
				(cmd(zoom, 2;stoptweening;diffusealpha,1;x,Xpos[GetActiveIndex(pn)];queuecommand,'Loop'))(self);
			end;
			LoopCommand=cmd(zoom, 2;stoptweening;zoom,2;diffusealpha,1;linear,.4;zoom,2;diffusealpha,.6;linear,.4;zoom,2;diffusealpha,1;queuecommand,'Loop');
			GoBackSelectingSongMessageCommand=cmd(zoom, 2;stoptweening;diffusealpha,0);
			OffCommand=cmd(zoom, 2;stoptweening;diffusealpha,0);
	
		};
		--
		a[#a+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/fulllevel_"..pn.."_text") )..{
			InitCommand=function(self)
				if pn == PLAYER_1 then
					self:y(-34);	
				else
					self:y(34);
				end;
			end;
			OnCommand=cmd(stoptweening;diffusealpha,0);
			StartSelectingStepsMessageCommand=function(self)
				if not GAMESTATE:IsSideJoined(pn) then return; end;
				(cmd(stoptweening;x,Xpos[GetActiveIndex(pn)];diffusealpha,0;zoom,1;sleep,.25;linear,.05;diffusealpha,1;queuecommand,'Loop'))(self);
			end;
			UpDateCursorCommand=function(self,params)
				if params.Player ~= pn then return; end;
				(cmd(stoptweening;diffusealpha,1;x,Xpos[GetActiveIndex(pn)];queuecommand,'Loop'))(self);
			end;
			LoopCommand=cmd(stoptweening;diffusealpha,1;zoom,1;linear,.4;zoom,1.1;diffusealpha,.6;linear,.4;zoom,1;diffusealpha,1;queuecommand,'Loop');
			GoBackSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,0);
			OffCommand=cmd(stoptweening;diffusealpha,0);
	
		};
		return a;
	else 
		return nil;
	end;
end;
	
	t[#t+1] = GetCursorFor(PLAYER_1);
	t[#t+1] = GetCursorFor(PLAYER_2);
	
	
return t;

--[[
for i=1,iChartsToShow do
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/ball.png") )..{
		OnCommand=cmd(x,-378+(i-1)*63);
	};
end


for i=1,iChartsToShow do

	-- Active Border --
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/active.png") ).. {
		InitCommand=cmd(x,-191+Xpos[i];y,250;zoom,1.5;diffusealpha,0);
		UpDateCommand=cmd( diffusealpha,GetActiveBallLabel(i); glowshift );
	};

	--	Glowing Ring --
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/glow_ring") ) .. {
		InitCommand=cmd(x,-191+Xpos[i];y,250;zoom,1.5;blend,'BlendMode_Add';diffusealpha,.2;playcommand,'Spin');
		SpinCommand=cmd(stoptweening;rotationz,0;linear,2;rotationz,-359;queuecommand,'Spin');
	}
	
	--	Dots Glow --
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/dots_glow") ) .. {
		InitCommand=cmd(x,-191+Xpos[i];y,250;zoom,1.5;blend,'BlendMode_Add';playcommand,'Loop');
		LoopCommand=cmd(stoptweening;y,-20;diffusealpha,0;linear,.5;y,0;diffusealpha,.2;linear,.5;y,20;diffusealpha,0;sleep,.5;queuecommand,'Loop');
	}
	
	--	DifficultyBalls --
	t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/fullbar balls 7x1.png") )..{
		InitCommand=cmd(x,-191+Xpos[i];y,250;zoom,1.5;pause);
		UpDateCommand=cmd( setstate,GetDiffNum(i);visible,GetDiffNum(i)~=4 );
	}
	
	-- Meters --
	t[#t+1] = LoadFont("N_SINGLE_N") .. {
		InitCommand=cmd(x,-191+Xpos[i]+1;y,250-1.1);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
		UpDateCommand=cmd( SetMeterValue,i,0 );
	};
	
	t[#t+1] = LoadFont("N_SINGLE_P") .. {
		InitCommand=cmd(x,-191+Xpos[i]+1;y,250-1.1);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
		UpDateCommand=cmd( SetMeterValue,i,2 );
	};
	
	t[#t+1] = LoadFont("N_DOUBLE_N") .. {
		InitCommand=cmd(x,-191+Xpos[i]+1;y,250-1.1);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
		UpDateCommand=cmd( SetMeterValue,i,1 );
	};
	
	t[#t+1] = LoadFont("N_DOUBLE_P") .. {
		InitCommand=cmd(x,-191+Xpos[i]+1;y,250-1.1);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
		UpDateCommand=cmd( SetMeterValue,i,3 );
	};

	t[#t+1] = LoadFont("N_DOUBLE_N") .. {
		InitCommand=cmd(x,-191+Xpos[i]+1;y,250-1.1);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
		UpDateCommand=cmd( SetMeterValue,i,5 );
	};

	t[#t+1] = LoadFont("N_COOP") .. {
		InitCommand=cmd(x,-191+Xpos[i]+1;y,250-1.1);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i]+1;linear,.3;y,250-1.1);
		UpDateCommand=cmd( SetMeterValue,i,6 );
	};
	
	-- Labels --
	t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/B_LABELS 1x12.png") ) .. {
		InitCommand=cmd(x,-191+Xpos[i];pause;y,250-22;zoom,.55);
		StartSelectingStepsMessageCommand=cmd(x,-191+Xpos[i];linear,.3;y,250-21);
		GoBackSelectingSongMessageCommand=cmd(x,-191+Xpos[i];linear,.3;y,250-22);
		UpDateCommand=cmd( setstate,GetSmallBallLabel(i) );
	};

	-- Top Rank
	t[#t+1] = Def.Sprite {
		Name="RankP1";
		Texture=THEME:GetPathG("", "RecordGrades/R_F (doubleres).png");
		InitCommand=cmd(x,Xpos[i];y,250-30;zoom,0.65);
		UpDateCommand=function(self)
			local Grade = GetPersonalGrade(PLAYER_1, i)
			if Grade ~= nil then
				self:Load(THEME:GetPathG("", "RecordGrades/" .. Grade .. " (doubleres).png"))
			else
				self:Load(nil)
			end
		end;
	};
	
	-- Bottom Rank
	t[#t+1] = Def.Sprite {
		Name="RankP2";
		Texture=THEME:GetPathG("", "RecordGrades/R_F (doubleres).png");
		InitCommand=cmd(x,Xpos[i];y,250+29;zoom,0.65);
		UpDateCommand=function(self)
			local Grade = GetPersonalGrade(PLAYER_2, i)
			if Grade ~= nil then
				self:Load(THEME:GetPathG("", "RecordGrades/" .. Grade .. " (doubleres).png"))
			else
				self:Load(nil)
			end
		end;
	};
	
	-- Under Labels --
	t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/B_UNDERLABELS 1x3") ).. {
		InitCommand=cmd(x,Xpos[i];pause;y,250+19;zoom,.5);
		UpDateCommand=cmd( setstate,GetUnderBallLabel(i) );
	};
	
end;

-- Pink arrows ------------------------------------------------
t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/fullbar_arrow") )..{
	InitCommand=function(self)
		(cmd(x,425;blend,'BlendMode_Add';zoom,.7;bounce;effectmagnitude,5,0,0;effectperiod,1))(self);
	end;
	UpDateCommand=function(self)
		if bIsExtensiveList then self:visible(true); else self:visible(false); end;
	end;
}

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/fullbar_arrow") )..{
	InitCommand=function(self)
		(cmd(x,-425;rotationz,180;blend,'BlendMode_Add';zoom,.7;bounce;effectmagnitude,-5,0,0;effectperiod,1))(self);
	end;
	UpDateCommand=function(self)
		if bIsExtensiveList then self:visible(true); else self:visible(false); end;
	end;
}
]]

