local t = Def.ActorFrame {}

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
--Sonidos
t[#t+1] = LoadActor( THEME:GetPathS("","CW/S_CMD_MOVE") )..{
	LocalProfileChangeMessageCommand=cmd(play);
	HideProfileChangesMessageCommand=cmd(play);
};

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

--1st Player
t[#t+1] = SimplePlatPiu(130,SCREEN_HEIGHT-160)..{ OffCommand=cmd(visible,false); };
t[#t+1] = PlayerMessage(PLAYER_1)..{
	OnCommand=cmd(zoom,0.66;x,-110;y,SCREEN_HEIGHT-90;linear,.4;x,130);
	PlayerAlreadyJoinedMessageCommand=function(self,params)
		if params.Player == PLAYER_1 then
			self:visible(false);
		end;
	end;
	OffCommand=cmd(visible,false); 
};

--2nd Player
t[#t+1] = SimplePlatPiu(SCREEN_WIDTH-130,SCREEN_HEIGHT-160)..{ OffCommand=cmd(visible,false); };
t[#t+1] = PlayerMessage(PLAYER_2)..{
	OnCommand=cmd(zoom,0.66;x,SCREEN_WIDTH+110;y,SCREEN_HEIGHT-90;linear,.4;x,SCREEN_WIDTH-130);
	PlayerAlreadyJoinedMessageCommand=function(self,params)
		if params.Player == PLAYER_2 then
			self:visible(false);
		end;
	end;
	OffCommand=cmd(visible,false); 
};
------------------------------------------------------------------------------------------------------------------

t[#t+1] = LoadActor(THEME:GetPathG("","Common Resources/FREE_PLAY.png") )..{
	InitCommand=cmd(zoom,0.45;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-12);
};

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
t[#t+1] = LoadFont("_myriad pro 20px")..{
	InitCommand=function(self)
		self:xy(SCREEN_LEFT+10, SCREEN_TOP+25)
		self:horizalign(left)
        self:vertalign(top)
		self:settext("v2.00.0\nPIU25-ABCDEFG00 (INT)\nPhyrebird")
		self:zoom(0.5)
	end;
	OffCommand=function(self)
		SCREENMAN:GetTopScreen():lockinput(.5)	-- para que cualquier entrada no interrumpa la transición de ventanas
		self:visible(false)
	end;
}

return t