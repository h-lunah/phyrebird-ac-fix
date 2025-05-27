local function GetPersonalGrade(pn)
	if GAMESTATE:IsSideJoined(pn) and GAMESTATE:HasProfile(pn) then
		local HighScores = PROFILEMAN:GetProfile(pn):GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(pn)):GetHighScores()
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

local t = Def.ActorFrame {
	InitCommand=function(self) self:visible(false) end,
	ChangeStepsMessageCommand=function(self) self:playcommand("Refresh") end,
	StartSelectingStepsMessageCommand=function(self) self:sleep(0.25) self:queuecommand("Visible") self:queuecommand("Refresh") end,
	
	VisibleCommand=function(self) self:visible(true) end,
	RefreshCommand=function(self)
		local PersonalP1 = GetPersonalGrade(PLAYER_1)
		if PersonalP1 ~= nil then
			local HSList = PROFILEMAN:GetProfile(PLAYER_1):GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(PLAYER_1)):GetHighScores()
			local PersonalP1Mods = HSList[1]:GetModifiers();
			local PersonalP1Judge = "nj";
			if string.find(PersonalP1Mods, " Easy") then
				PersonalP1Judge = "ej"
			elseif string.find(PersonalP1Mods, " Normal") then
				PersonalP1Judge = "nj"
			elseif string.find(PersonalP1Mods, " Hard") then
				PersonalP1Judge = "hj"
			elseif string.find(PersonalP1Mods, " VeryHard") then
				PersonalP1Judge = "vj"
			elseif string.find(PersonalP1Mods, " ExtraHard") then
				PersonalP1Judge = "xj"
			elseif string.find(PersonalP1Mods, " UltraHard") then
				PersonalP1Judge = "uj"
			end;
			self:GetChild("PersonalP1"):Load(THEME:GetPathG("", "RecordGrades/" .. PersonalP1 .. " (doubleres).png"))
		else
			self:GetChild("PersonalP1"):Load(nil)
		end
		
		local PersonalP2 = GetPersonalGrade(PLAYER_2)
		if PersonalP2 ~= nil then
			local HSList = PROFILEMAN:GetProfile(PLAYER_2):GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(PLAYER_2)):GetHighScores()
			local PersonalP2Mods = HSList[1]:GetModifiers();
			local PersonalP2Judge = "nj"
			if string.find(PersonalP2Mods, " Easy") then
				PersonalP2Judge = "ej"
			elseif string.find(PersonalP2Mods, " Normal") then
				PersonalP2Judge = "nj"
			elseif string.find(PersonalP2Mods, " Hard") then
				PersonalP2Judge = "hj"
			elseif string.find(PersonalP2Mods, " VeryHard") then
				PersonalP2Judge = "vj"
			elseif string.find(PersonalP2Mods, " ExtraHard") then
				PersonalP2Judge = "xj"
			elseif string.find(PersonalP2Mods, " UltraHard") then
				PersonalP2Judge = "uj"
			end;
			self:GetChild("PersonalP2"):Load(THEME:GetPathG("", "RecordGrades/" .. PersonalP2 .. " (doubleres).png"))
		else
			self:GetChild("PersonalP2"):Load(nil)
		end
	end,
	
	GoBackSelectingSongMessageCommand=function(self) self:stoptweening() self:visible(false) end,
	OffCommand=function(self) self:visible(false) end,
	
	Def.Sprite {
		Name="PersonalP1",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 286, SCREEN_CENTER_Y + 172)
			self:zoom(0.95)
		end
	},
	
	Def.Sprite {
		Name="PersonalP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 286, SCREEN_CENTER_Y + 172)
			self:zoom(0.95)
		end
	}
}

return t
