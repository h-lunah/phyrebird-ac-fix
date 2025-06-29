local t = Def.ActorFrame {}

--1st Player
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
t[#t+1] = PlayerMessage(PLAYER_2)..{
	OnCommand=cmd(zoom,0.66;x,SCREEN_WIDTH+110;y,SCREEN_HEIGHT-90;linear,.4;x,SCREEN_WIDTH-130);
	PlayerAlreadyJoinedMessageCommand=function(self,params)
		if params.Player == PLAYER_2 then
			self:visible(false);
		end;
	end;
	OffCommand=cmd(visible,false); 
};

return t