local t = Def.ActorFrame {}

local goback = cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
local start  = cmd(stoptweening;diffusealpha,0;sleep,.1;linear,.1;diffusealpha,1);
local init_black = cmd(stoptweening;diffusealpha,0;sleep,.3;diffusealpha,1);
local common = cmd(stoptweening;diffusealpha,0;linear,.1;diffusealpha,.5;linear,.2;diffusealpha,1);
local init_pink_for_basic = cmd(stoptweening;diffusealpha,0;linear,.1;diffusealpha,.5;linear,.2;diffusealpha,1;linear,.5;diffusealpha,0);
local shift_command = cmd(stoptweening;stopeffect;zoom,1;diffusealpha,.7;sleep,.15;linear,.15;diffusealpha,0;zoom,1.02;queuecommand,'Effect');

local zoom_factor = 0.66;
--local zoom_factor = 1;
----------------------------------------------------------------------------------------------------------------------------
--UpLeft--

local UL_ARROW = Def.ActorFrame {
	InitCommand=cmd(x,45-145;y,45-145;zoom,0.67);
	OnCommand=cmd(stoptweening;sleep,.1;linear,.1;x,45;y,45);
	OffCommand=cmd(stoptweening;x,45;y,45;sleep,.2;linear,.1;x,45-145;y,45-145;diffusealpha,.2;sleep,0;x,45;y,45;diffusealpha,1);
	children = {
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/left_black") )..{
			InitCommand=cmd(diffusealpha,0;y,-6);
			GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,0;linear,.2;diffusealpha,0.8);
			StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/left_pink") )..{
			InitCommand=cmd(blend,'BlendMode_Add';y,-6;diffusealpha,1);
			GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
			StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,0;linear,.2;diffusealpha,1);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/UpLeft 4x2.png") )..{
			OnCommand=cmd(zoom,0.67);
			GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
			StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,0;linear,.2;diffusealpha,1);
		};
	};
}

local UR_ARROW = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_WIDTH-45+145;y,45-145;zoom,0.67);
	OnCommand=cmd(stoptweening;sleep,.1;linear,.1;x,SCREEN_WIDTH-45;y,45);
	OffCommand=cmd(stoptweening;x,SCREEN_WIDTH-45;y,45;sleep,.2;linear,.1;x,SCREEN_WIDTH-45+145;y,45-145;diffusealpha,.2;sleep,0;x,SCREEN_WIDTH-45;y,45;diffusealpha,1);
	children = {
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/right_black") )..{
			InitCommand=cmd(diffusealpha,0;y,-6);
			GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,0;linear,.2;diffusealpha,0.8);
			StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/right_pink") )..{
			InitCommand=cmd(blend,'BlendMode_Add';y,-6;diffusealpha,1);
			GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
			StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,0;linear,.2;diffusealpha,1);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/UpLeft 4x2.png") )..{
			OnCommand=cmd(zoom,0.67;rotationy,180);
			GoBackSelectingGroupMessageCommand=cmd(stoptweening;diffusealpha,1;linear,.2;diffusealpha,0);
			StartSelectingSongMessageCommand=cmd(stoptweening;diffusealpha,0;linear,.2;diffusealpha,1);
		};
	};
}

local blue_arrows_shine_shift = cmd(stoptweening;diffusealpha,0;zoom,1;linear,.1;diffusealpha,.8;linear,.2;zoom,1.2;diffusealpha,0);
local blue_arrows_graph_shift = cmd(stoptweening;stopeffect;diffusealpha,.1;zoom,1.08;linear,.2;diffusealpha,.5;zoom,1.1;linear,.2;diffusealpha,0;zoom,1.08;queuecommand,'ContinueEffect');

local DR_ARROW = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_WIDTH-45+145;y,SCREEN_HEIGHT-45+145;zoom,0.67);
	OnCommand=cmd(stoptweening;sleep,.1;linear,.1;x,SCREEN_WIDTH-45;y,SCREEN_HEIGHT-45);
	OffCommand=cmd(stoptweening;x,SCREEN_WIDTH-45;y,SCREEN_HEIGHT-45;sleep,.2;linear,.1;x,SCREEN_WIDTH-45+145;y,SCREEN_HEIGHT-45+145;diffusealpha,.2;sleep,0;x,SCREEN_WIDTH-45;y,SCREEN_HEIGHT-45;diffusealpha,1);
	children = {
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/right_blue") )..{
			InitCommand=cmd(blend,'BlendMode_Add';y,6;diffusealpha,1);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/DownLeft 4x2.png") )..{
			InitCommand=cmd(zoom,0.67;rotationy,180);
		};
		Def.ActorFrame {
			BeginCommand=cmd(y,6);
			OffCommand=cmd(visible,false);
			children = {
				LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/right_blue") )..{
					OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,0);
					NextSongMessageCommand=blue_arrows_shine_shift;
					NextGroupMessageCommand=blue_arrows_shine_shift;
				};
			};
		};
	};
}

local DL_ARROW = Def.ActorFrame {
	InitCommand=cmd(x,45-145;y,SCREEN_HEIGHT-45+145;zoom,0.67);
	OnCommand=cmd(stoptweening;sleep,.1;linear,.1;x,45;y,SCREEN_HEIGHT-45);
	OffCommand=cmd(stoptweening;x,45;y,SCREEN_HEIGHT-45;sleep,.2;linear,.1;x,45-145;y,SCREEN_HEIGHT-45+145;diffusealpha,.2;sleep,0;x,45;y,SCREEN_HEIGHT-45;diffusealpha,1);
	children = {
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/left_blue") )..{
			InitCommand=cmd(blend,'BlendMode_Add';y,6;diffusealpha,1);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/DownLeft 4x2.png") )..{
			InitCommand=cmd(zoom,0.67);
		};
		Def.ActorFrame {
			BeginCommand=cmd(y,6);
			OffCommand=cmd(visible,false);
			children = {
				LoadActor( THEME:GetPathG("","ScreenSelectMusic/_Arrows/left_blue") )..{
					OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,0);
					PreviousSongMessageCommand=blue_arrows_shine_shift;
					PrevGroupMessageCommand=blue_arrows_shine_shift;
				};
			};
		};
	};
}

t[#t+1] = UL_ARROW;
t[#t+1] = UR_ARROW;
t[#t+1] = DR_ARROW;
t[#t+1] = DL_ARROW;

return t;