local t = Def.ActorFrame {};

t[#t+1] = LoadActor( BGDirB.."/Teaser" )..{
	InitCommand=cmd(Center;show_background_properly);	
	OnCommand=cmd(play);
};

t[#t+1] = LoadActor( THEME:GetPathG("","_resources/mainLogo.png") )..{
	--InitCommand=cmd(basezoom,.50;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;pulse;effectmagnitude,1,0.75,0.5;effectperiod,3);
	InitCommand=function(self)
		self:basezoom(.55)
		self:x(SCREEN_CENTER_X)
		self:y(SCREEN_CENTER_Y)
		self:queuecommand("Animate")
	end,
	AnimateCommand=function(self)
		self:accelerate(0.9)
		self:zoom(0.95)
		self:decelerate(0.9)
		self:zoom(0.9)
		self:accelerate(0.9)
		self:zoom(0.95)
		self:decelerate(0.9)
		self:zoom(1)
		self:queuecommand("Animate")
	end
};

return t;
