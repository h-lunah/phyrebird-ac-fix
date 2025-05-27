local t = Def.ActorFrame {};

t[#t+1] = LoadActor(THEME:GetPathS("","Sounds/JOIN.mp3"))..{
	PlayerJoinedMessageCommand=cmd(play);
}

t[#t+1] = LoadActor(THEME:GetPathG("","Common Resources/FREE_PLAY.png") )..{
	InitCommand=cmd(zoom,0.45;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-12);
};

t[#t+1] = LoadActor(THEME:GetPathG("","ScreenSelectPlayModeBranch/BG.png"))..{
	InitCommand=cmd(show_background_properly);
	OnCommand=cmd(visible,false);
	PlayerJoinedMessageCommand=cmd(visible,true);
}

return t;
