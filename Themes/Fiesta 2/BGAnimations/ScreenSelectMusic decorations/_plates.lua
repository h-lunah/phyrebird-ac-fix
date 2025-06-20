local function GetPersonalPlate(pn)
	if GAMESTATE:IsSideJoined(pn) and GAMESTATE:HasProfile(pn) then
		local HighScores = PROFILEMAN:GetProfile(pn):GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(pn)):GetHighScores()
		if #HighScores ~= 0 then
			local BestScore = math.floor(HighScores[1]:GetScore()/100);
			if BestScore > 2000000 then
				return nil 
			end
			if BestScore > 1000000 then
				BestScore = BestScore - 1000000;
				local greats = HighScores[1]:GetTapNoteScore('TapNoteScore_W3');
				local goods = HighScores[1]:GetTapNoteScore('TapNoteScore_W4');
				local bads = HighScores[1]:GetTapNoteScore('TapNoteScore_W5');
				local misses = HighScores[1]:GetTapNoteScore('TapNoteScore_Miss') + HighScores[1]:GetTapNoteScore('TapNoteScore_CheckpointMiss');		
				local plate = CalcPlateInitials(greats,goods,bads,misses);
				return plate;
			end;
			return nil
		else
			return nil
		end
	else
		return nil
	end
end

local function GetMachinePlate(pn)
	if GAMESTATE:IsSideJoined(pn) then
		local HighScores = PROFILEMAN:GetMachineProfile():GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(pn)):GetHighScores()
		if #HighScores ~= 0 then
			local BestScore = math.floor(HighScores[1]:GetScore()/100);
			if BestScore > 2000000 then
				return nil 
			end
			if BestScore > 1000000 then
				BestScore = BestScore - 1000000;
				local greats = HighScores[1]:GetTapNoteScore('TapNoteScore_W3');
				local goods = HighScores[1]:GetTapNoteScore('TapNoteScore_W4');
				local bads = HighScores[1]:GetTapNoteScore('TapNoteScore_W5');
				local misses = HighScores[1]:GetTapNoteScore('TapNoteScore_Miss') + HighScores[1]:GetTapNoteScore('TapNoteScore_CheckpointMiss');		
				local plate = CalcPlateInitials(greats,goods,bads,misses);
				return plate;
			end;
			return nil
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
		local PersonalP1 = GetPersonalPlate(PLAYER_1)
		if PersonalP1 ~= nil then
			self:GetChild("PersonalP1"):Load(THEME:GetPathG("", "RecordGrades/" .. PersonalP1 .. " (doubleres).png"))
		else
			self:GetChild("PersonalP1"):Load(nil)
		end
		
		local MachineP1 = GetMachinePlate(PLAYER_1)
		if MachineP1 ~= nil then
			self:GetChild("MachineP1"):Load(THEME:GetPathG("", "RecordGrades/" .. MachineP1 .. " (doubleres).png"))
		else
			self:GetChild("MachineP1"):Load(nil)
		end
		
		local PersonalP2 = GetPersonalPlate(PLAYER_2)
		if PersonalP2 ~= nil then
			self:GetChild("PersonalP2"):Load(THEME:GetPathG("", "RecordGrades/" .. PersonalP2 .. " (doubleres).png"))
		else
			self:GetChild("PersonalP2"):Load(nil)
		end

		local MachineP2 = GetMachinePlate(PLAYER_2)
		if MachineP2 ~= nil then
			self:GetChild("MachineP2"):Load(THEME:GetPathG("", "RecordGrades/" .. MachineP2 .. " (doubleres).png"))
		else
			self:GetChild("MachineP2"):Load(nil)
		end
	end,
	
	GoBackSelectingSongMessageCommand=function(self) self:stoptweening() self:visible(false) end,
	OffCommand=function(self) self:visible(false) end,
	
	Def.Sprite {
		Name="PersonalP1",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 216, SCREEN_CENTER_Y + 172)
			self:zoom(1.25)
		end
	},

	Def.Sprite {
		Name="MachineP1",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 235, SCREEN_CENTER_Y + 148)
			self:zoom(0.37)
			self:visible(false)
		end
	},


	Def.Sprite {
		Name="PersonalP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 216, SCREEN_CENTER_Y + 172)
			self:zoom(1.25)
		end
	},
	

		Def.Sprite {
		Name="MachineP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 305, SCREEN_CENTER_Y + 148)
			self:zoom(0.37)
			self:visible(false)
		end
	}
	
}

return t
