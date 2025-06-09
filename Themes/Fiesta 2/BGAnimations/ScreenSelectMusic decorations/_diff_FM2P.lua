local t = Def.ActorFrame {}

if GAMESTATE:IsSideJoined(PLAYER_2) then
    t[#t+1] = GetBallLevelColor(PLAYER_2,true)..{InitCommand=cmd(basezoom,.90;zoomx,-1;y,20)};
    t[#t+1] = GetBallLevelTextP2(PLAYER_2,true)..{InitCommand=cmd(basezoom,.90;y,20)};
end;

return t;