local t = Def.ActorFrame {}

if GAMESTATE:IsSideJoined(PLAYER_1) then
    t[#t+1] = GetBallLevelColor(PLAYER_1,true)..{InitCommand=cmd(basezoom,.90;y,20)};
    t[#t+1] = GetBallLevelTextP1(PLAYER_1,true)..{InitCommand=cmd(basezoom,.90;y,20)};
end;

return t;