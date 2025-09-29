local t = Def.ActorFrame{}

local num = math.random(0,5);

return Def.ActorFrame {
	children = {
		LoadActor( THEME:GetPathG("","ScreenBranch/WP"..num..".png") )..{
			InitCommand=cmd(scale_or_crop_background);
		};
	}
}

