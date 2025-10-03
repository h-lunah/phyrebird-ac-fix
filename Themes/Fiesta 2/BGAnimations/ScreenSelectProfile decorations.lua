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
------------------------------------------------------------------------------------------------------------------
t[#t+1] = LoadFont("_myriad pro 20px")..{
	InitCommand=function(self)
		local random_id = ""
		random_id = random_id.."PIU25-"

		local ascii
		local char
		
		for i=1,9,1 do
			repeat
				ascii = math.random(48,90)
			
			until (ascii <= 57) or (ascii >= 65)

			char = string.char(ascii)
			random_id = random_id..char
		end

		self:xy(SCREEN_LEFT+10, SCREEN_TOP+35)
		self:horizalign(left)
        self:vertalign(top)
		self:settext("v2.00.0\n"..random_id.." (INT)\nPhyrebird")
		self:zoom(0.5)
	end;
	OffCommand=function(self)
		SCREENMAN:GetTopScreen():lockinput(.5)	-- para que cualquier entrada no interrumpa la transición de ventanas
		self:visible(false)
	end;
}

t[#t+1] = LoadFont("_myriad pro Blue bold 20px")..{
	InitCommand=function(self)
		self:settext("")
		self:xy(SCREEN_CENTER_X, SCREEN_BOTTOM-40)
		self:zoom(0.66)
	end;
	OnCommand=function(self)
		if IsNetConnected() then
			self:settext("ONLINE")
		else
			self:settext("OFFLINE")
		end
	end;
}

return t