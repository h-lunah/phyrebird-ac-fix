local t = Def.ActorFrame{}

t[#t+1] = LoadActor(THEME:GetPathG("","ScreenWarning/phoenix_warning_en"))..{
    InitCommand=function(self)
        self:FullScreen()
        self:diffusealpha(0)
        self:linear(0.2)
        self:diffusealpha(1)
    end,
}

return t;