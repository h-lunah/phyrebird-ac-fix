local t = Def.ActorFrame {}

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/banner_left") )..{
	InitCommand=cmd(zoom,0.67;x,-72);
	OnCommand=cmd(finishtweening;x,-60;zoom,0;linear,.3;x,-72;zoom,.67;queuecommand,'Loop');
	LoopCommand=cmd(finishtweening;diffusealpha,1;linear,.5;diffusealpha,.9;linear,.5;diffusealpha,1;queuecommand,'Loop');
	PreviousSongMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,.67;x,-72;linear,.1;zoom,.8;x,-90;linear,.1;zoom,.67;x,-72;queuecommand,'Loop');
	NextSongMessageCommand=cmd(finishtweening;diffusealpha,1;sleep,.3;queuecommand,'Loop');
	StartSelectingStepsMessageCommand=cmd(finishtweening;x,-72;zoom,0.67;linear,.15;x,-60;zoom,0;queuecommand,'Loop');
	GoBackSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,-60;zoom,0;linear,.15;x,-72;zoom,0.67;queuecommand,'Loop');
	GoBackSelectingGroupMessageCommand=cmd(finishtweening;x,-72;zoom,0.67;linear,.15;x,-60;zoom,0;queuecommand,'Loop');
	StartSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,-60;zoom,0;linear,.15;x,-72;zoom,.67;queuecommand,'Loop');
};

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/banner_right") )..{
	InitCommand=cmd(zoom,0.67;x,72);
	OnCommand=cmd(finishtweening;x,60;zoom,0;linear,.3;x,72;zoom,.67;queuecommand,'Loop');
	LoopCommand=cmd(finishtweening;diffusealpha,1;linear,.5;diffusealpha,.9;linear,.5;diffusealpha,1;queuecommand,'Loop');
	NextSongMessageCommand=cmd(finishtweening;diffusealpha,1;zoom,.67;x,72;linear,.1;x,90;zoom,.8;linear,.15;x,72;zoom,.67;queuecommand,'Loop');
	PreviousSongMessageCommand=cmd(finishtweening;diffusealpha,1;sleep,.3;queuecommand,'Loop');
	StartSelectingStepsMessageCommand=cmd(finishtweening;x,72;zoom,0.67;linear,.15;x,60;zoom,0;queuecommand,'Loop');
	GoBackSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,60;zoom,0;linear,.15;x,72;zoom,0.67;queuecommand,'Loop');
	GoBackSelectingGroupMessageCommand=cmd(finishtweening;x,72;zoom,0.67;linear,.15;x,60;zoom,0;queuecommand,'Loop');
	StartSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,60;zoom,0;linear,.15;x,72;zoom,.67;queuecommand,'Loop');
};

-----------Triangulos Superiores

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/banner_triangle") )..{
	InitCommand=cmd(zoom,0.67;x,-58;y,-44);
	OnCommand=cmd(finishtweening;zoom,0;linear,.3;zoom,.67;queuecommand,'Loop');
	LoopCommand=cmd(finishtweening;x,-58;y,-44;linear,.4;x,-63;y,-49;linear,.4;x,-58;y,-44;queuecommand,'Loop');
	PreviousSongMessageCommand=cmd(finishtweening;x,-58;y,-44;linear,.2;x,-70;y,-56;linear,.2;x,-58;y,-44;queuecommand,'Loop');
	NextSongMessageCommand=cmd(finishtweening;x,-58;y,-44;linear,.2;x,-70;y,-56;linear,.2;x,-58;y,-44;queuecommand,'Loop');
	StartSelectingStepsMessageCommand=cmd(finishtweening;x,-58;y,-44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	GoBackSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,-58;y,-44;queuecommand,'Loop');
	GoBackSelectingGroupMessageCommand=cmd(finishtweening;x,-58;y,-44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	StartSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,-58;y,-44;queuecommand,'Loop');
};

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/banner_triangle") )..{
	InitCommand=cmd(zoom,0.67;x,58;y,-44;rotationy,180);
	OnCommand=cmd(finishtweening;zoom,0;linear,.3;zoom,.67;queuecommand,'Loop');
	LoopCommand=cmd(finishtweening;x,58;y,-44;linear,.4;x,63;y,-49;linear,.4;x,58;y,-44;queuecommand,'Loop');
	PreviousSongMessageCommand=cmd(finishtweening;x,58;y,-44;linear,.2;x,70;y,-56;linear,.2;x,58;y,-44;queuecommand,'Loop');
	NextSongMessageCommand=cmd(finishtweening;x,58;y,-44;linear,.2;x,70;y,-56;linear,.2;x,58;y,-44;queuecommand,'Loop');
	StartSelectingStepsMessageCommand=cmd(finishtweening;x,58;y,-44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	GoBackSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,58;y,-44;queuecommand,'Loop');
	GoBackSelectingGroupMessageCommand=cmd(finishtweening;x,58;y,-44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	StartSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,58;y,-44;queuecommand,'Loop');
};

-----------Triangulos Inferiores

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/banner_triangle") )..{
	InitCommand=cmd(zoom,0.67;x,-58;y,44;rotationx,180);
	OnCommand=cmd(finishtweening;zoom,0;linear,.3;zoom,.67;queuecommand,'Loop');
	LoopCommand=cmd(finishtweening;x,-58;y,44;linear,.4;x,-63;y,49;linear,.4;x,-58;y,44;queuecommand,'Loop');
	PreviousSongMessageCommand=cmd(finishtweening;x,-58;y,44;linear,.2;x,-70;y,56;linear,.2;x,-58;y,44;queuecommand,'Loop');
	NextSongMessageCommand=cmd(finishtweening;x,-58;y,44;linear,.2;x,-70;y,56;linear,.2;x,-58;y,44;queuecommand,'Loop');
	StartSelectingStepsMessageCommand=cmd(finishtweening;x,-58;y,44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	GoBackSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,-58;y,44;queuecommand,'Loop');
	GoBackSelectingGroupMessageCommand=cmd(finishtweening;x,-58;y,44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	StartSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,-58;y,44;queuecommand,'Loop');
};

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenSelectMusic/banner_triangle") )..{
	InitCommand=cmd(zoom,0.67;x,58;y,44;rotationy,180;;rotationx,180);
	OnCommand=cmd(finishtweening;zoom,0;linear,.3;zoom,.67;queuecommand,'Loop');
	LoopCommand=cmd(finishtweening;x,58;y,44;linear,.4;x,63;y,49;linear,.4;x,58;y,44;queuecommand,'Loop');
	PreviousSongMessageCommand=cmd(finishtweening;x,58;y,44;linear,.2;x,70;y,56;linear,.2;x,58;y,44;queuecommand,'Loop');
	NextSongMessageCommand=cmd(finishtweening;x,58;y,44;linear,.2;x,70;y,56;linear,.2;x,58;y,44;queuecommand,'Loop');
	StartSelectingStepsMessageCommand=cmd(finishtweening;x,58;y,44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	GoBackSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,58;y,44;queuecommand,'Loop');
	GoBackSelectingGroupMessageCommand=cmd(finishtweening;x,58;y,44;linear,.15;diffusealpha,0;x,0;y,0;queuecommand,'Loop');
	StartSelectingSongMessageCommand=cmd(finishtweening;sleep,.15;x,0;y,0;linear,.15;diffusealpha,1;x,58;y,44;queuecommand,'Loop');
};

return t