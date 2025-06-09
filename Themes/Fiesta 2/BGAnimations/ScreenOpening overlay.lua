local t = Def.ActorFrame {};

t[#t+1] = LoadActor(THEME:GetPathG("","Common Resources/FREE_PLAY.png") )..{
	InitCommand=cmd(zoom,0.45;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-12);
};

return t;
