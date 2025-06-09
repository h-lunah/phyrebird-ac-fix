local t = Def.ActorFrame {};

t[#t+1] = LoadActor( BGDirB.."/ST_BK"..tostring( STATSMAN:GetStagesPlayed() % 2 ) ) .. {
	InitCommand=cmd(FullScreen;loop,false);
	OnCommand=cmd(play);
};

t[#t+1] = LoadActor(THEME:GetPathS("","Sounds/ST_BREAK"..tostring( STATSMAN:GetStagesPlayed() % 2 )))..{
	OnCommand=cmd(play)
}

return t;
