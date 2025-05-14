local t = Def.ActorFrame {};

t[#t+1] = LoadActor( THEME:GetPathG("","ScreenMproject/MPROJECT") )..{
	InitCommand=cmd(FullScreen;diffusealpha,0;sleep,1;linear,.2;diffusealpha,1;sleep,3;linear,.2;diffusealpha,0)
}

return t;