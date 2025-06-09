local t = Def.ActorFrame {}

-- Contador

--t[#t+1] = LoadFont("_karnivore lite Bold white")..{
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(y,0);
	CurrentSongChangedMessageCommand=function(self)
		local index = SCREENMAN:GetTopScreen():GetWheelCurrentIndex()+1;
		local numitems = SCREENMAN:GetTopScreen():GetWheelNumItems();
		local total_d4 = self:GetChild("TOTAL_D4");
		local total_d3 = self:GetChild("TOTAL_D3");
		local total_d2 = self:GetChild("TOTAL_D2");
		local total_d1 = self:GetChild("TOTAL_D1");
		local curindex_d4 = self:GetChild("CURINDEX_D4");
		local curindex_d3 = self:GetChild("CURINDEX_D3");
		local curindex_d2 = self:GetChild("CURINDEX_D2");
		local curindex_d1 = self:GetChild("CURINDEX_D1");
		
		if numitems < 9999 then
			local total_milhares = math.floor(numitems/1000)*1000;
			local total_centenas = math.floor((numitems - total_milhares)/100)*100;
			local total_decenas = math.floor((numitems - total_milhares - total_centenas)/10)*10;
			local total_unidad = math.floor(numitems - total_milhares - total_centenas - total_decenas);
			total_d4:setstate( math.floor(total_milhares/1000) );
			total_d3:setstate( math.floor(total_centenas/100) );
			total_d2:setstate( math.floor(total_decenas/10) );
			total_d1:setstate( math.floor(total_unidad) );
		else
			total_d4:setstate( 9 );			
			total_d3:setstate( 9 );
			total_d2:setstate( 9 );
			total_d1:setstate( 9 );
		end;
		
		if index < 9999 then
			local curindex_milhares = math.floor(index/1000)*1000;
			local curindex_centenas = math.floor((index - curindex_milhares)/100)*100;
			local curindex_decenas = math.floor((index - curindex_milhares - curindex_centenas)/10)*10;
			local curindex_unidad = math.floor(index - curindex_milhares - curindex_centenas - curindex_decenas);
			curindex_d4:setstate( math.floor(curindex_milhares/1000) );
			curindex_d3:setstate( math.floor(curindex_centenas/100) );
			curindex_d2:setstate( math.floor(curindex_decenas/10) );
			curindex_d1:setstate( math.floor(curindex_unidad) );
		else
			curindex_d4:setstate( 9 );
			curindex_d3:setstate( 9 );
			curindex_d2:setstate( 9 );
			curindex_d1:setstate( 9 );
		end;
	end;
	children = {
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/_counter_div") )..{
			InitCommand=cmd(basezoom,0.68);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="TOTAL_D4";
			InitCommand=cmd(pause;x,8;basezoom,.4;setstate,2);
		};
			LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="TOTAL_D3";
			InitCommand=cmd(pause;x,16;basezoom,.4;setstate,2);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="TOTAL_D2";
			InitCommand=cmd(pause;x,24;basezoom,.4);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="TOTAL_D1";
			InitCommand=cmd(pause;x,32;basezoom,.4);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="CURINDEX_D4";
			InitCommand=cmd(pause;x,-32;basezoom,.4);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="CURINDEX_D3";
			InitCommand=cmd(pause;x,-24;basezoom,.4);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="CURINDEX_D2";
			InitCommand=cmd(pause;x,-16;basezoom,.4);
		};
		LoadActor( THEME:GetPathG("","ScreenSelectMusic/SongIndexNumber 10x1") )..{
			Name="CURINDEX_D1";
			InitCommand=cmd(pause;x,-8;basezoom,.4);
		};
	};
}

return t