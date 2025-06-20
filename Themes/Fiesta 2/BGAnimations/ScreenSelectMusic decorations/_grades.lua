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

local function GetMachineGrade(pn)
	if GAMESTATE:IsSideJoined(pn) then
		local HighScores = PROFILEMAN:GetMachineProfile():GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(pn)):GetHighScores()
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
			self:GetChild("PersonalP1Mods"):Load(THEME:GetPathG("", "ScreenSelectMusic/"..PersonalP1Judge..".png"))
		else
			self:GetChild("PersonalP1"):Load(nil)
			self:GetChild("PersonalP1Mods"):Load(nil)
		end
		
		local MachineP1 = GetMachineGrade(PLAYER_1)
		if MachineP1 ~= nil then
			local HSListMachine = PROFILEMAN:GetMachineProfile():GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(PLAYER_1)):GetHighScores()
			local MachineP1Mods = HSListMachine[1]:GetModifiers();
			local MachineP1Judge = "nj"
			if string.find(MachineP1Mods, " Easy") then
				MachineP1Judge = "ej"
			elseif string.find(MachineP1Mods, " Normal") then
				MachineP1Judge = "nj"
			elseif string.find(MachineP1Mods, " Hard") then
				MachineP1Judge = "hj"
			elseif string.find(MachineP1Mods, " VeryHard") then
				MachineP1Judge = "vj"
			elseif string.find(MachineP1Mods, " ExtraHard") then
				MachineP1Judge = "xj"
			elseif string.find(MachineP1Mods, " UltraHard") then
				MachineP1Judge = "uj"
			end;
			self:GetChild("MachineP1"):Load(THEME:GetPathG("", "RecordGrades/" .. MachineP1 .. " (doubleres).png"))
			self:GetChild("MachineP1Mods"):Load(THEME:GetPathG("", "ScreenSelectMusic/"..MachineP1Judge..".png"))
		else
			self:GetChild("MachineP1"):Load(nil)
			self:GetChild("MachineP1Mods"):Load(nil)
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
			self:GetChild("PersonalP2Mods"):Load(THEME:GetPathG("", "ScreenSelectMusic/"..PersonalP2Judge..".png"))
		else
			self:GetChild("PersonalP2"):Load(nil)
			self:GetChild("PersonalP2Mods"):Load(nil)
		end
		
		local MachineP2 = GetMachineGrade(PLAYER_2)
		if MachineP2 ~= nil then
			local HSListMachine = PROFILEMAN:GetMachineProfile():GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(PLAYER_2)):GetHighScores()
			local MachineP2Mods = HSListMachine[1]:GetModifiers();
			local MachineP2Judge = "nj"
			if string.find(MachineP2Mods, " Easy") then
				MachineP2Judge = "ej"
			elseif string.find(MachineP2Mods, " Normal") then
				MachineP2Judge = "nj"
			elseif string.find(MachineP2Mods, " Hard") then
				MachineP2Judge = "hj"
			elseif string.find(MachineP2Mods, " VeryHard") then
				MachineP2Judge = "vj"
			elseif string.find(MachineP2Mods, " ExtraHard") then
				MachineP2Judge = "xj"
			elseif string.find(MachineP2Mods, " UltraHard") then
				MachineP2Judge = "uj"
			end;
			self:GetChild("MachineP2"):Load(THEME:GetPathG("", "RecordGrades/" .. MachineP2 .. " (doubleres).png"))
			self:GetChild("MachineP2Mods"):Load(THEME:GetPathG("", "ScreenSelectMusic/"..MachineP2Judge..".png"))
		else
			self:GetChild("MachineP2"):Load(nil)
			self:GetChild("MachineP2Mods"):Load(nil)
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
		Name="PersonalP1Mods",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 205, SCREEN_CENTER_Y + 118)
			self:zoom(0.37)
			self:visible(false)
		end
	},
	
	Def.Sprite {
		Name="MachineP1",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 235, SCREEN_CENTER_Y + 158)
			self:zoom(0.37)
			self:visible(false)
		end
	},

	Def.Sprite {
		Name="MachineP1Mods",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 205, SCREEN_CENTER_Y + 148)
			self:zoom(0.37)
			self:visible(false)
		end
	},

	Def.Sprite {
		Name="PersonalP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 286, SCREEN_CENTER_Y + 172)
			self:zoom(0.95)
		end

	},


	Def.Sprite {
		Name="PersonalP2Mods",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 335, SCREEN_CENTER_Y + 118)
			self:zoom(0.37)
			self:visible(false)
		end
	},
	
	Def.Sprite {
		Name="MachineP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 305, SCREEN_CENTER_Y + 158)
			self:zoom(0.37)
			self:visible(false)
		end
	},

	Def.Sprite {
		Name="MachineP2Mods",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 335, SCREEN_CENTER_Y + 148)
			self:zoom(0.37)
			self:visible(false)
		end
	}
}

return t
