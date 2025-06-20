local t = Def.ActorFrame {};

local t = Def.ActorFrame {
	CurrentSongChangedMessageCommand=function(self)
		song = GAMESTATE:GetCurrentSong();
	end;
	
	Def.Sprite {
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;scaletoclipped,1280 ,720);
		CurrentSongChangedMessageCommand=function(self)
			self:stoptweening();
			self:diffusealpha(0.9);
			self:sleep(0.5);
		end;
	};
	
	Def.Sprite {
		Texture="Next_Song 5x3",
			Frame0000=0,
			Delay0000=0.05,
			Frame0001=1,
			Delay0001=0.05,
			Frame0002=2,
			Delay0002=0.05,
			Frame0003=3,
			Delay0003=0.05,
			Frame0004=4,
			Delay0004=0.05,
			Frame0005=5,
			Delay0005=0.05,
			Frame0006=6,
			Delay0006=0.05,
			Frame0007=7,
			Delay0007=0.05,
			Frame0008=8,
			Delay0008=0.05,
			Frame0009=9,
			Delay0009=0.05,
			Frame0010=10,
			Delay0010=0.05,
			Frame0011=11,
			Delay0011=0.05,
			Frame0012=12,
			Delay0012=0.05,
		InitCommand=cmd(diffusealpha,0;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center);
		OnCommand=cmd(diffusealpha,0;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center);
		NextSongMessageCommand=cmd(finishtweening;diffusealpha,1;sleep,0.9;diffusealpha,0;);
		PreviousSongMessageCommand=cmd(finishtweening;);
		StartSelectingSongMessageCommand=cmd(finishtweening;diffusealpha,1;sleep,0.9;diffusealpha,0;);
	};
	
	
Def.Sprite {
		Texture="Prev_Song 5x3",
			Frame0000=0,
			Delay0000=0.05,
			Frame0001=1,
			Delay0001=0.05,
			Frame0002=2,
			Delay0002=0.05,
			Frame0003=3,
			Delay0003=0.05,
			Frame0004=4,
			Delay0004=0.05,
			Frame0005=5,
			Delay0005=0.05,
			Frame0006=6,
			Delay0006=0.05,
			Frame0007=7,
			Delay0007=0.05,
			Frame0008=8,
			Delay0008=0.05,
			Frame0009=9,
			Delay0009=0.05,
			Frame0010=10,
			Delay0010=0.05,
			Frame0011=11,
			Delay0011=0.05,
			Frame0012=12,
			Delay0012=0.05,
			Frame0013=13,
			Delay0013=0.05,
			Frame0014=14,
			Delay0014=0.05,
		InitCommand=cmd(diffusealpha,0;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center);
		OnCommand=cmd(diffusealpha,0;zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;Center);
		PreviousSongMessageCommand=cmd(finishtweening;diffusealpha,1;sleep,0.9;diffusealpha,0;);
		NextSongMessageCommand=cmd(finishtweening;);
	};
	
	
};

return t;
