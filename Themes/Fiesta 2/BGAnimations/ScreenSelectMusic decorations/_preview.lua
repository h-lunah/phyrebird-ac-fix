local t = Def.ActorFrame {}

----------------------------------------------------------------------------------------
local nPlayersJoined = GAMESTATE:GetNumSidesJoined();

if nPlayersJoined == 1 then
	--GREEN QUEST SHADOW
	local g = Def.ActorFrame {
		InitCommand=cmd(y,-10);
		OnCommand=cmd(visible,false);
		StartSelectingStepsMessageCommand=cmd(stoptweening;visible,false;sleep,.2;queuecommand,'ChangeSteps');
		GoBackSelectingSongMessageCommand=cmd(stoptweening;visible,false);
		OffCommand=cmd(stoptweening;visible,false);
		ChangeStepsMessageCommand=function(self)
			self:stoptweening();
			if nPlayersJoined > 1 then
				self:visible(false);
				return;
			end;
			if #(GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetChartName()) ~= 0 then
				local label = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetLabel();
				if(label == "QUEST" or label == "HIDDEN" or GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):ShowInfoBar()) then
					self:visible(true);
				else
					self:visible(false);
				end;
			else
				self:visible(false);
			end;
		end;
	};
		
	g[#g+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/preview_shadow_one_player") )..{
		InitCommand=cmd(y,-10;basezoom,.675)
	};
	
	g[#g+1] = LoadFont("_myriad pro 20px")..{
		OnCommand=cmd(y,-10;stoptweening;shadowlength,0;zoom,.8;maxwidth,300);
		ChangeStepsMessageCommand=cmd(playcommand,'UpdateText');
		StartSelectingStepsMessageCommand=cmd(playcommand,'UpdateText');
		UpdateTextCommand=function(self)
			local text = GAMESTATE:GetCurrentSteps( GAMESTATE:GetMasterPlayerNumber() ):GetChartName();
			if string.len(text) >= 70 then
				text = string.sub(text,1,68);
				text = text .. "...";
			end;
			self:settext( text );
		end;
	};
	
	t[#t+1] = g;
	
elseif nPlayersJoined == 2 then	
	local h = Def.ActorFrame {
		InitCommand=cmd(y,-10);
		OnCommand=cmd(visible,false);
		StartSelectingStepsMessageCommand=cmd(stoptweening;visible,false;sleep,.2;queuecommand,'ChangeSteps');
		GoBackSelectingSongMessageCommand=cmd(stoptweening;visible,false);
		OffCommand=cmd(stoptweening;visible,false);
		ChangeStepsMessageCommand=function(self)
			self:stoptweening();
			if nPlayersJoined < 2 then
				self:visible(false);
				return;
			end;
			
			local label_p1 = GAMESTATE:GetCurrentSteps( PLAYER_1 ):GetLabel();
			local label_p2 = GAMESTATE:GetCurrentSteps( PLAYER_2 ):GetLabel();
			
			if (GAMESTATE:GetCurrentSteps( PLAYER_1 ):GetChartName() ~= "" and (label_p1 == "QUEST" or label_p1 == "HIDDEN" or GAMESTATE:GetCurrentSteps( PLAYER_1 ):ShowInfoBar())) or (GAMESTATE:GetCurrentSteps( PLAYER_2 ):GetChartName() ~= "" and (label_p2 == "QUEST" or label_p2 == "HIDDEN" or GAMESTATE:GetCurrentSteps( PLAYER_2 ):ShowInfoBar()))then
				self:visible(true);
			else
				self:visible(false);
			end;
		end;
		PlayerJoinedMessageCommand=function(self)
			nPlayersJoined = GAMESTATE:GetNumSidesJoined();
		end;
	};
	
	h[#h+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/preview_shadow_two_players") )..{
		InitCommand=cmd(y,-10;basezoom,.675)
	};
	
	--TEXT FOR PLAYER 1
	h[#h+1] = LoadFont("_myriad pro 20px")..{
		OnCommand=cmd(stoptweening;y,-45;shadowlength,0;zoom,.8;maxwidth,360);
		ChangeStepsMessageCommand=cmd(stoptweening;playcommand,'UpdateText');
		StartSelectingStepsMessageCommand=cmd(stoptweening;playcommand,'UpdateText');
		UpdateTextCommand=function(self)
			if not GAMESTATE:IsSideJoined( PLAYER_1 ) then
				return;
			end;
			local text = GAMESTATE:GetCurrentSteps( PLAYER_1 ):GetChartName();
			if string.len(text) >= 70 then
				text = string.sub(text,1,67);
				text = text .. "...";
			end;
			self:settext( text );
		end;
	};
	
	--TEXT FOR PLAYER 2
	h[#h+1] = LoadFont("_myriad pro 20px")..{
		OnCommand=cmd(stoptweening;y,25;shadowlength,0;zoom,.8;maxwidth,360);
		ChangeStepsMessageCommand=cmd(stoptweening;playcommand,'UpdateText');
		StartSelectingStepsMessageCommand=cmd(stoptweening;playcommand,'UpdateText');
		UpdateTextCommand=function(self)
			if not GAMESTATE:IsSideJoined( PLAYER_2 ) then
				return;
			end;
			local text = GAMESTATE:GetCurrentSteps( PLAYER_2 ):GetChartName();
			if string.len(text) >= 70 then
				text = string.sub(text,1,67);
				text = text .. "...";
			end;
			self:settext( text );
		end;
	};
	
	t[#t+1] =h;
end;

t[#t+1] = Def.ActorFrame {
	GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,0);
	StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,.4;linear,.1;diffusealpha,1);
	OnCommand=cmd(playcommand,'CurrentSongChanged');
	OffCommand=cmd(stoptweening;visible,false);
	CurrentSongChangedMessageCommand=function(self)
		local cur_song = GAMESTATE:GetCurrentSong();
		if not cur_song then
			self:visible(false);
			return;
		end;
		
		self:visible(true);
		
		local bpm1;
		local bpm2;
		local bpm_size;
		local bpm_number = self:GetChild("bpm_number");
		local bpm_text = self:GetChild("bpm_text");
		local artist = self:GetChild("artist");
		local title = self:GetChild("title");
		
		if( cur_song:IsDisplayBpmSecret() ) then
			bpm_number:settext("???");
		else
			bpm1 = cur_song:GetDisplayBpmsText()[1];
			bpm2 = cur_song:GetDisplayBpmsText()[2];
			if( bpm1 ~= bpm2 ) then
				bpm_number:settext(bpm1.."-"..bpm2);
			else
				bpm_number:settext(bpm1);
			end;
		end;
		bpmW = math.floor(bpm_number:GetZoomedWidth());
--		bpm_text:;
		
		--artist:maxwidth( (296-bpmW-30)*(1/.6) );
		artist:settext( cur_song:GetDisplayArtist() );
		
		local group = SCREENMAN:GetTopScreen():GetCurrentGroup();

		if( group == "SO_RANDOM" ) then
			title:settext( "???" );
		else
			title:settext( cur_song:GetDisplayMainTitle() );
		end;
	end;
	PlayableStepsChangedMessageCommand=function(self)
		local cur_song = GAMESTATE:GetCurrentSong();
		if not cur_song then
			self:visible(false);
			return;
		end;
		
		self:visible(true);
		local duration = self:GetChild("duration");
		local currentsurvivalseconds = 0;
		local highestsurvivalseconds = 0;
		local formattedtime = "";
		local aSteps = SCREENMAN:GetTopScreen():GetPlayableSteps();
		local numSteps = #aSteps;
		for i=1,numSteps do
			local HighScoresList = PROFILEMAN:GetMachineProfile():GetHighScoreListIfExists(cur_song,aSteps[i]);
			if HighScoresList ~= nil then
				local HighScores = HighScoresList:GetHighScores();
				if HighScores ~= nil then
					local BestScore = HighScores[1];
					if BestScore ~= nil then
						currentsurvivalseconds = BestScore:GetSurvivalSeconds();
						if currentsurvivalseconds ~= nil and currentsurvivalseconds > highestsurvivalseconds then
							highestsurvivalseconds = currentsurvivalseconds;
						end;
					end;
				end;
			end;
		end;
		if highestsurvivalseconds > 0 then formattedtime = FormatTime(highestsurvivalseconds) end;
		local group = SCREENMAN:GetTopScreen():GetCurrentGroup();
		if( group == "SO_RANDOM" ) then
			duration:settext( "??:??" );
		else
			duration:settext( formattedtime );
		end;
	end;
	children = {
		LoadFont("_myriad pro 20px")..{
			InitCommand=cmd(stoptweening;y,96;zoom,.7;shadowlength,0;settext,"/";diffuse,1,1,1,1);
			NextSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
			PreviousSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
		};
		LoadFont("_myriad pro 20px")..{
			Name="bpm_text";
			InitCommand=cmd(stoptweening;y,96;x,18;zoom,.6;shadowlength,0;settext,"BPM";diffuse,1,0,0,1);
			NextSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
			PreviousSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
		};
		LoadFont("_myriad pro 20px")..{
			Name="bpm_number";
			InitCommand=cmd(stoptweening;horizalign,left;y,96;x,32;zoom,.6;shadowlength,0;settext,"";diffuse,1,0,0,1;maxwidth,180);
			NextSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
			PreviousSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
		};
		LoadFont("_myriad pro 20px")..{
			Name="artist";
			InitCommand=cmd(stoptweening;horizalign,right;y,96;x,-6;zoom,.6;shadowlength,0;diffuse,1,1,0,1;maxwidth,403);
			NextSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
			PreviousSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
		};
		LoadFont("_myriad pro 20px")..{
			Name="title";
			InitCommand=cmd(stoptweening;horizalign,center;y,74;zoom,1;shadowlength,1;maxwidth,600);
			NextSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
			PreviousSongMessageCommand=cmd(stoptweening;diffusealpha,0;sleep,0.8;linear,0.15;diffusealpha,1);
		};
	};
};

return t

