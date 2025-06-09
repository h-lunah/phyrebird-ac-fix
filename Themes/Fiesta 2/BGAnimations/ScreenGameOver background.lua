local t = Def.ActorFrame {};

t[#t+1] = LoadActor( BGDirB.."GAME_OVER" ) .. {
	InitCommand=cmd(FullScreen;loop,false);
	OnCommand=cmd(play)
};

return t;