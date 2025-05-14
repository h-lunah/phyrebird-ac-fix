local t = Def.ActorFrame {};

t[#t+1] = LoadActor( BGDirB.."/NST"..tostring( STATSMAN:GetStagesPlayed() % 5 ) ) .. {
	InitCommand=cmd(FullScreen;loop,false);
	OnCommand=cmd(play);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/CREDIT_B") )..{
		InitCommand=cmd(zoom,.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-8)
}

return t;