local t = Def.ActorFrame {};

t[#t+1] = LoadActor( BGDirB.."/ST_BK" )..{
	InitCommand=cmd(FullScreen;loop,false);
	OnCommand=cmd(play);
};

t[#t+1] = LoadActor( THEME:GetPathG("","Common Resources/CREDIT_B") )..{
		InitCommand=function(self)
			self:xy(428, 470)
            self:zoom(0.5)
        end
	}

return t;
