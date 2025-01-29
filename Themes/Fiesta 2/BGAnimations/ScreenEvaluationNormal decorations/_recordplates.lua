local PersonalP1, MachineP1, PersonalP2, MachineP2

local function GetPersonalPlate(pn, i)
	if GAMESTATE:IsSideJoined(pn) and GAMESTATE:HasProfile(pn) then
		local HighScores = PROFILEMAN:GetProfile(pn):GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(pn)):GetHighScores()
		if #HighScores ~= 0 and HighScores[i] ~= nil then
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

local function GetMachinePlate(pn, i)
	if GAMESTATE:IsSideJoined(pn) then
		local HighScores = PROFILEMAN:GetMachineProfile():GetHighScoreList(GAMESTATE:GetCurrentSong(), GAMESTATE:GetCurrentSteps(pn)):GetHighScores()
		if #HighScores ~= 0 and HighScores[i] ~= nil then
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
	OnCommand=function(self)
	end,
	
	Def.Sprite {
		Name="PersonalP1",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 240, SCREEN_CENTER_Y + 138)
			self:zoom(0.37)
		end,
		OnCommand=function(self)
			self:sleep(0.5)
			self:queuecommand("FirstPlate")
			self:sleep(3.9)
			self:queuecommand("SecondPlate")
		end,
		FirstPlateCommand=function(self) 
			local NewScoreP1 = SCREENMAN:GetTopScreen():PlayerHasNewRecord(PLAYER_1)
			PersonalP1 = GetPersonalPlate(PLAYER_1, (NewScoreP1 and 2 or 1)) 
			self:playcommand("Refresh")
		end,
		SecondPlateCommand=function(self) 
			PersonalP1 = GetPersonalPlate(PLAYER_1, 1) 
			self:playcommand("Refresh")
		end,
		RefreshCommand=function(self) self:Load(PersonalP1 ~= nil and THEME:GetPathG("", "RecordGrades/" .. PersonalP1 .. " (doubleres).png") or nil) end
	},
	
	Def.Sprite {
		Name="MachineP1",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 240, SCREEN_CENTER_Y + 172)
			self:zoom(0.37)
		end,
		OnCommand=function(self)
			self:sleep(0.5)
			self:queuecommand("FirstPlate")
			self:sleep(3.9)
			self:queuecommand("SecondPlate")
		end,
		FirstPlateCommand=function(self) 
			local NewScoreP1 = SCREENMAN:GetTopScreen():PlayerHasNewMachineRecord(PLAYER_1)
			local NewScoreP2 = SCREENMAN:GetTopScreen():PlayerHasNewMachineRecord(PLAYER_2)
			local NewMachineScore = (NewScoreP1 or NewScoreP2)
			MachineP1 = GetMachinePlate(PLAYER_1, (NewMachineScore and 2 or 1)) 
			self:playcommand("Refresh")
		end,
		SecondPlateCommand=function(self) 
			MachineP1 = GetMachinePlate(PLAYER_1, 1) 
			self:playcommand("Refresh")
		end,
		RefreshCommand=function(self)
			self:Load(MachineP1 ~= nil and THEME:GetPathG("", "RecordGrades/" .. MachineP1 .. " (doubleres).png") or nil)
		end
	},
	
	Def.Sprite {
		Name="PersonalP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 320, SCREEN_CENTER_Y + 138)
			self:zoom(0.37)
		end,
		OnCommand=function(self)
			self:sleep(0.5)
			self:queuecommand("FirstPlate")
			self:sleep(3.9)
			self:queuecommand("SecondPlate")
		end,
		FirstPlateCommand=function(self) 
			local NewScoreP2 = SCREENMAN:GetTopScreen():PlayerHasNewRecord(PLAYER_2)
			PersonalP2 = GetPersonalPlate(PLAYER_2, (NewScoreP2 and 2 or 1)) 
			self:playcommand("Refresh")
		end,
		SecondPlateCommand=function(self) 
			PersonalP2 = GetPersonalPlate(PLAYER_2, 1) 
			self:playcommand("Refresh")
		end,
		RefreshCommand=function(self) self:Load(PersonalP2 ~= nil and THEME:GetPathG("", "RecordGrades/" .. PersonalP2 .. " (doubleres).png") or nil) end
	},
	
	Def.Sprite {
		Name="MachineP2",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 320, SCREEN_CENTER_Y + 172)
			self:zoom(0.37)
		end,
		OnCommand=function(self)
			self:sleep(0.5)
			self:queuecommand("FirstPlate")
			self:sleep(3.9)
			self:queuecommand("SecondPlate")
		end,
		FirstPlateCommand=function(self) 
			local NewScoreP1 = SCREENMAN:GetTopScreen():PlayerHasNewMachineRecord(PLAYER_1)
			local NewScoreP2 = SCREENMAN:GetTopScreen():PlayerHasNewMachineRecord(PLAYER_2)
			local NewMachineScore = (NewScoreP1 or NewScoreP2)
			MachineP2 = GetMachinePlate(PLAYER_2, (NewMachineScore and 2 or 1)) 
			self:playcommand("Refresh")
		end,
		SecondPlateCommand=function(self) 
			MachineP2 = GetMachinePlate(PLAYER_2, 1) 
			self:playcommand("Refresh")
		end,
		RefreshCommand=function(self)
			self:Load(MachineP2 ~= nil and THEME:GetPathG("", "RecordGrades/" .. MachineP2 .. " (doubleres).png") or nil)
		end
	}
}

return t
