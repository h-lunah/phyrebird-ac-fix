--///////////////////////////////////////////////////////////////////////////////////////////////////
-- LISTA LOS ARCHIVOS DE SONIDO DE LOS CANALES
ChannelsSoundsFiles = {};

local SortsSounds = {
	{"SO_ALLTUNES", 	"new_tunes.ogg"};
	{"SO_FULLSONGS", 	"full_songs.ogg"};
	{"SO_REMIX", 		"remix.ogg"};
	{"SO_SHORTCUT", 	"shortcut.ogg"};
	{"SO_ORIGINAL", 	"original.ogg"};
	{"SO_KPOP", 		"kpop.ogg"};
	{"SO_WORLDMUSIC", 	"world_music.ogg"};
	{"SO_UCS", 			"silent.ogg"};
	{"SO_QUEST", 		"silent.ogg"};
	{"SO_COOP", 		"silent.ogg"};
	{"SO_RANDOM", 	"silent.ogg"};
	{"SO_JMUSIC", 	"j_music.ogg"};
	{"SO_XROSS", 	"xross.ogg"};
	{"SO_LEVEL_1", 	"silent.ogg"};
	{"SO_LEVEL_2", 	"silent.ogg"};
	{"SO_LEVEL_3", 	"silent.ogg"};
	{"SO_LEVEL_4", 	"silent.ogg"};
	{"SO_LEVEL_5",  "silent.ogg"};
	{"SO_LEVEL_6", 	"silent.ogg"};
	{"SO_LEVEL_7",  "silent.ogg"};
	{"SO_LEVEL_8", 	"silent.ogg"};
	{"SO_LEVEL_9", 	"silent.ogg"};
	{"SO_LEVEL_10", "silent.ogg"};
	{"SO_LEVEL_11", "silent.ogg"};
	{"SO_LEVEL_12", "silent.ogg"};
	{"SO_LEVEL_13", "silent.ogg"};
	{"SO_LEVEL_14", "silent.ogg"};
	{"SO_LEVEL_15", "silent.ogg"};
	{"SO_LEVEL_16", "silent.ogg"};
	{"SO_LEVEL_17", "silent.ogg"};
	{"SO_LEVEL_18", "silent.ogg"};
	{"SO_LEVEL_19", "silent.ogg"};
	{"SO_LEVEL_20", "silent.ogg"};
	{"SO_LEVEL_21", "silent.ogg"};
	{"SO_LEVEL_22", "silent.ogg"};
	{"SO_LEVEL_23", "silent.ogg"};
	{"SO_LEVEL_24", "silent.ogg"}
}

ChannelsToScale = {
}

local ChannelsSounds = {
	["01 - 1ST~ZERO"] = 		"1st_to_zero.ogg";
	["02 - NX~NXA"] = 		"nx_to_nxa.ogg";
	["03 - FIESTA~FIESTA2"] = 		"fiesta_to_fiesta2.ogg";
	["04 - PRIME"] = 			"prime.ogg";
	["05 - PRIME 2"] = 			"prime2.ogg";
	["06 - XX"] = 			"xx.ogg";
	["07 - PHOENIX"] = 			"phoenix.ogg";
}

local function GetChannelSoundDir( name )
	local fir = "Songs/"..name.."/info/";
	local ogg = fir..'sound.ogg';
	local mp3 = fir..'sound.mp3';
	local wav = fir..'sound.wav';

	if (FILEMAN:DoesFileExist(ogg)) then return ogg;
	elseif (FILEMAN:DoesFileExist(mp3)) then return mp3;
	elseif (FILEMAN:DoesFileExist(wav)) then return wav;
	else return ""; end;
	
end;

function LoadChannelsSounds()
	local AllGroups = SONGMAN:GetSongGroupNames();
	
	for i=1,#SortsSounds do
		local sortc = SortsSounds[i][1];
		ChannelsSoundsFiles[tostring(sortc)] = "Themes/Fiesta 2/Sounds/ChannelsSounds/"..SortsSounds[i][2];
	end;
	
	for i=1,#AllGroups do
		local cur_group = AllGroups[i];
		local sound = ChannelsSounds[cur_group];
		local dir = "";
		if( sound ) then
			dir = "Themes/Fiesta 2/Sounds/ChannelsSounds/"..sound;
		else
			dir = GetChannelSoundDir( cur_group );
		end;
		
		if( dir ~= "" )then
			ChannelsSoundsFiles[tostring(cur_group)] = tostring(dir);
		end;
	end;
end;

--///////////////////////////////////////////////////////////////////////////////////////////////////
-- LISTA DE GRAFICOS DE LOS CANALES AUTOMATICOS
ChannelsGraphics = {
	["SO_ALLTUNES"] = 	"C_ATUNES.PNG";
	["SO_RANDOM"] = 	"C_RD.PNG";
	["SO_FULLSONGS"] = 	"C_FSONG.PNG";
	["SO_REMIX"] = 		"C_RMX.PNG",
	["SO_SHORTCUT"] = 	"C_SC.PNG";
	["SO_ORIGINAL"] = 	"C_OT.PNG";
	["SO_KPOP"] = 		"C_KP.PNG";
	["SO_WORLDMUSIC"] = "C_WM.PNG";
	["SO_UCS"] = 		"C_UCS.PNG";
	["SO_QUEST"] = 		"C_MZ.PNG";
	["SO_COOP"] = 		"C_COOP.PNG";
	["SO_LEVEL_1"] = "C_LV_01.PNG";
	["SO_LEVEL_2"] = "C_LV_02.PNG";
	["SO_LEVEL_3"] = "C_LV_03.PNG";
	["SO_LEVEL_4"] = "C_LV_04.PNG";
	["SO_LEVEL_5"] = "C_LV_05.PNG";
	["SO_LEVEL_6"] = "C_LV_06.PNG";
	["SO_LEVEL_7"] = "C_LV_07.PNG";
	["SO_LEVEL_8"] = "C_LV_08.PNG";
	["SO_LEVEL_9"] = "C_LV_09.PNG";
	["SO_LEVEL_10"] = "C_LV_10.PNG";
	["SO_LEVEL_11"] = "C_LV_11.PNG";
	["SO_LEVEL_12"] = "C_LV_12.PNG";
	["SO_LEVEL_13"] = "C_LV_13.PNG";
	["SO_LEVEL_14"] = "C_LV_14.PNG";
	["SO_LEVEL_15"] = "C_LV_15.PNG";
	["SO_LEVEL_16"] = "C_LV_16.PNG";
	["SO_LEVEL_17"] = "C_LV_17.PNG";
	["SO_LEVEL_18"] = "C_LV_18.PNG";
	["SO_LEVEL_19"] = "C_LV_19.PNG";
	["SO_LEVEL_20"] = "C_LV_20.PNG";
	["SO_LEVEL_21"] = "C_LV_21.PNG";
	["SO_LEVEL_22"] = "C_LV_22.PNG";
	["SO_LEVEL_23"] = "C_LV_23.PNG";
	["SO_LEVEL_24"] = "C_LV_24O.PNG";
	["SO_JMUSIC"] = "C_JM.PNG";
	["SO_XCROSS"] = "C_XR.png";
	["01 - 1ST~ZERO"] = 		"C_LOGO1.PNG";
	["02 - NX~NXA"] = 	"C_NXA.PNG";
    ["03 - FIESTA~FIESTA2"] = "C_FIESTA2.PNG";
	["04 - PRIME"] = 		"C_PR.PNG";
	["05 - PRIME 2"] = 	"C_PR2.PNG";
	["06 - XX"] = 	"C_XX.PNG";
	["07 - PHOENIX"] = "C_PHOENIX.png";
	["08 - PRO~PRO2"] = 	"C_PRO.PNG";
	["09 - INFINITY"] = 	"C_INFINITY.PNG";
	["10 - MOBILE EDITION"] = 	"C_ME.PNG";
}

--///////////////////////////////////////////////////////////////////////////////////////////////////
-- LISTA DE DESCRIPCIONES DE LOS CANALES
-- [left, top, right, bot]

local ChannelsTextCoordSpanish = {
	["SO_ALLTUNES"] = 		 "En este canal, puedes jugar todas las canciones estándar." ;
	["SO_ORIGINAL"] = 		 "En este canal, puedes jugar una variedad de las canciones\noriginales de PIU." ;
	["SO_KPOP"] =			 "En este canal, puedes jugar una variedad de canciones de K-POP." ;
	["SO_WORLDMUSIC"] = 	 "En este canal, puedes jugar una\nvariedad de canciones de todo el mundo." ;
	["SO_UCS"] = 			 "En este canal, puedes jugar tus steps personalizados." ;
	["SO_QUEST"] = 			 "En este canal, puedes jugar una recopilación de misiones." ;
	["SO_COOP"] = 			 "En este canal, puedes jugar canciones que requieren\nun juego cooperativo de dos o más jugadores." ;
	["SO_RANDOM"] = 		 "En este canal, puedes jugar una canción seleccionada\nal azar en una dificultad especifica." ;
	["SO_FULLSONGS"] = 		 "En este canal, puedes jugar canciones originales sin modificación." ;
	["SO_REMIX"] = 			 "En este canal, puedes jugar canciones mezcladas." ;
	["SO_SHORTCUT"] = 		 "En este canal, puedes jugar canciones que han sido\neditadas a un minuto de duración." ;
	["01 - 1ST~ZERO"] = 		 "En este canal, puedes jugar las canciones típicas de las versiones\n1st hasta ZERO." ;
	["02 - NX~NXA"] = 		 "En este canal, puedes jugar las canciones típicas de las versiones\nNX hasta NXA." ;
	["08 - PRO~PRO2"] = 		 "En este canal, puedes jugar las canciones típicas de las versiones\nPRO y PRO2." ;
	["03 - FIESTA~FIESTA2"] = 		 "En este canal, puedes jugar las canciones de las versiones\nFIESTA hasta FIESTA 2." ;
	["09 -INFINITY"] = 		 "En este canal, puedes jugar las canciones de la versión INFINITY." ;
	["04 - PRIME"] = 			 "En este canal, puedes jugar las canciones de la versión PRIME." ;
	["05 - PRIME 2"] = 	     "En este canal, puedes jugar las canciones de la versión PRIME 2." ;
    ["06 - XX"] = 			 "En este canal, puedes jugar las canciones de la versión XX." ;
	["10 - MOBILE EDITION"] =	"En este canal, puedes jugar las canciones de la versión MOBILE EDITION." ;
	["07 - PHOENIX"] =	"En este canal, puedes jugar las canciones de la versiôn PHOENIX." ;
	["SO_LEVEL_1"] =  "En este canal, puedes jugar canciones de nivel 1." ;
	["SO_LEVEL_2"] =  "En este canal, puedes jugar canciones de nivel 2." ;
	["SO_LEVEL_3"] =  "En este canal, puedes jugar canciones de nivel 3." ;
	["SO_LEVEL_4"] =  "En este canal, puedes jugar canciones de nivel 4." ;
	["SO_LEVEL_5"] =  "En este canal, puedes jugar canciones de nivel 5." ;
	["SO_LEVEL_6"] =  "En este canal, puedes jugar canciones de nivel 6." ;
	["SO_LEVEL_7"] =  "En este canal, puedes jugar canciones de nivel 7." ;
	["SO_LEVEL_8"] =  "En este canal, puedes jugar canciones de nivel 8." ;
	["SO_LEVEL_9"] =  "En este canal, puedes jugar canciones de nivel 9." ;
	["SO_LEVEL_10"] =  "En este canal, puedes jugar canciones de nivel 10." ;
	["SO_LEVEL_11"] =  "En este canal, puedes jugar canciones de nivel 11." ;
	["SO_LEVEL_12"] =  "En este canal, puedes jugar canciones de nivel 12." ;
	["SO_LEVEL_13"] =  "En este canal, puedes jugar canciones de nivel 13." ;
	["SO_LEVEL_14"] =  "En este canal, puedes jugar canciones de nivel 14." ;
	["SO_LEVEL_15"] =  "En este canal, puedes jugar canciones de nivel 15." ;
	["SO_LEVEL_16"] =  "En este canal, puedes jugar canciones de nivel 16." ;
	["SO_LEVEL_17"] =  "En este canal, puedes jugar canciones de nivel 17." ;
	["SO_LEVEL_18"] =  "En este canal, puedes jugar canciones de nivel 18." ;
	["SO_LEVEL_19"] =  "En este canal, puedes jugar canciones de nivel 19." ;
	["SO_LEVEL_20"] =  "En este canal, puedes jugar canciones de nivel 20." ;
	["SO_LEVEL_21"] =  "En este canal, puedes jugar canciones de nivel 21." ;
	["SO_LEVEL_22"] =  "En este canal, puedes jugar canciones de nivel 22." ;
	["SO_LEVEL_23"] =  "En este canal, puedes jugar canciones de nivel 23." ;
	["SO_LEVEL_24"] =  "En este canal, puedes jugar canciones de nivel 24 o más." ;
	["SO_JMUSIC"] =  "En este canal, puedes jugar una variedad de canciones japonesas." ;
	["SO_XROSS"] =  "En este canal, puedes jugar una variedad de canciones de otros juegos." ;
}

local ChannelsTextCoordEnglish = {
	["SO_ALLTUNES"] = 		 "In this channel, you can play all the standard songs." ;  -- this channel should be named New Tunes
	["SO_ORIGINAL"] = 		 "In this channel, you can play a variety of PIU original songs." ;
	["SO_KPOP"] =			 "In this channel, you can play a variety of K-POP songs." ;
	["SO_WORLDMUSIC"] = 	 "In this channel, you can play a variety of world music." ;
	["SO_UCS"] = 			 "In this channel, you can play your own customized steps." ;
	["SO_QUEST"] = 			 "In this special channel, you can play the gathered Quests." ;
	["SO_COOP"] = 			 "In this channel, you can play song that require co-op of two or more players." ;
	["SO_RANDOM"] = 		 "In this channel, you can play a certain song selected randomly\nwithin specific difficulties." ; -- this channel does not exist in Phoenix
	["SO_FULLSONGS"] = 		 "In this channel, you can play the original songs that are not edited." ;
	["SO_REMIX"] = 			 "In this channel, you can play a various songs that are remixed." ;
	["SO_SHORTCUT"] = 		 "In this channel, you can play a various songs\nthat are edited around a 1 minute length." ;
	["01 - 1ST~ZERO"] = 		 "In this channel, you can play songs originally from PIU 1st to PIU ZERO." ;
	["02 - NX~NXA"] = 		"In this channel, you can play songs originally from PIU NX to PIU NXA." ;
	["03 - FIESTA~FIESTA2"] = 		 "In this channel, you can play songs originally from PIU FIESTA to PIU FIESTA 2." ;
	["04 - PRIME"] = 			 "In this channel, you can play songs originally from PIU PRIME." ;
	["05 - PRIME 2"] = 	    "In this channel, you can play songs originally from PIU PRIME 2." ;
    ["06 - XX"] = 			  "In this channel, you can play songs originally from PIU XX." ;
	["07 - PHOENIX"] =	"In this channel, you can play songs originally from PIU PHOENIX." ;
	["08 - PRO~PRO2"] = 		 "In this channel, you can play songs originally from PRO to PRO2." ; 
	["09 - INFINITY"] = 		 "In this channel, you can play songs originally from PIU INFINITY." ;
	["10 - MOBILE EDITION"] =	"In this channel, you can play songs originally from MOBILE EDITION." ;
	["SO_LEVEL_1"] =  "In this channel, you can play level 1 difficulty songs." ;
	["SO_LEVEL_2"] =  "In this channel, you can play level 2 difficulty songs." ;
	["SO_LEVEL_3"] =  "In this channel, you can play level 3 difficulty songs." ;
	["SO_LEVEL_4"] =  "In this channel, you can play level 4 difficulty songs." ;
	["SO_LEVEL_5"] =  "In this channel, you can play level 5 difficulty songs." ;
	["SO_LEVEL_6"] =  "In this channel, you can play level 6 difficulty songs." ;
	["SO_LEVEL_7"] =  "In this channel, you can play level 7 difficulty songs." ;
	["SO_LEVEL_8"] =  "In this channel, you can play level 8 difficulty songs." ;
	["SO_LEVEL_9"] =  "In this channel, you can play level 9 difficulty songs." ;
	["SO_LEVEL_10"] =  "In this channel, you can play level 10 difficulty songs." ;
	["SO_LEVEL_11"] =  "In this channel, you can play level 11 difficulty songs." ;
	["SO_LEVEL_12"] =  "In this channel, you can play level 12 difficulty songs." ;
	["SO_LEVEL_13"] =  "In this channel, you can play level 13 difficulty songs." ;
	["SO_LEVEL_14"] =  "In this channel, you can play level 14 difficulty songs." ;
	["SO_LEVEL_15"] =  "In this channel, you can play level 15 difficulty songs." ;
	["SO_LEVEL_16"] =  "In this channel, you can play level 16 difficulty songs." ;
	["SO_LEVEL_17"] =  "In this channel, you can play level 17 difficulty songs." ;
	["SO_LEVEL_18"] =  "In this channel, you can play level 18 difficulty songs." ;
	["SO_LEVEL_19"] =  "In this channel, you can play level 19 difficulty songs." ;
	["SO_LEVEL_20"] =  "In this channel, you can play level 20 difficulty songs." ;
	["SO_LEVEL_21"] =  "In this channel, you can play level 21 difficulty songs." ;
	["SO_LEVEL_22"] =  "In this channel, you can play level 22 difficulty songs." ;
	["SO_LEVEL_23"] =  "In this channel, you can play level 23 difficulty songs." ;
	["SO_LEVEL_24"] =  "In this channel, you can play songs that are level 24 difficulty or higher." ;
	["SO_JMUSIC"] =  "In this channel, you can play a variety of Japanese musics." ;
	["SO_XROSS"] =  "In this channel, you can play cross licensed songs." ;
}

Descriptions = {
	["es"] = ChannelsTextCoordSpanish;
	["en"] = ChannelsTextCoordEnglish;
}

--///////////////////////////////////////////////////////////////////////////////////////////////////
local numberss = { "1","2","3","4","5","6","7","8","9","0" };

function IsANumber( num )
	local toret = false;
	for i=1,#numberss do
		if num == numberss[i] then
			toret = true;
		end;
	end;
	return toret;
end;

function StringAt( str, i )
	return string.sub(str,i,i);
end;

local Renames = {
	["SO_ALLTUNES"] = 		"ALL TUNES";
	["SO_RANDOM"] = 		"RANDOM";
	["SO_ORIGINAL"] = 		"ORIGINAL";
	["SO_KPOP"] = 			"K-POP";
	["SO_WORLDMUSIC"] = 	"WORLD MUSIC";
	["SO_FULLSONGS"] = 		"FULL SONGS";
	["SO_REMIX"] = 			"REMIX",
	["SO_SHORTCUT"] = 		"SHORT CUT";
	["SO_UCS"] = 			"U.C. STEP";
	["SO_COOP"] = 			"CO-OP";
	["SO_QUEST"] = 			"MISSION ZONE";
	
	["01 - 1ST~ZERO"] = 		"1ST~ZERO";
	["02 - NX~NXA"] = 		"NX~NXA";
	["03 - FIESTA~FIESTA2"] = 		"FIESTA";
	["04 - PRIME"] = 			"PRIME";
	["05 - PRIME 2"] = 		"PRIME 2";
	["06 - XX"] = 		"XX";
	["07 - PHOENIX"] = 		"PHOENIX";
	["08 - PRO~PRO2"] = 	"PRO~PRO2";
	["09 - INFINITY"] = 		"INFINITY";
	["10 - MOBILE EDITION"] = 		"MOBILE EDITION";
	
	["SO_LEVEL_1"] = "LEVEL 1";
	["SO_LEVEL_2"] = "LEVEL 2";
	["SO_LEVEL_3"] = "LEVEL 3";
	["SO_LEVEL_4"] = "LEVEL 4";
	["SO_LEVEL_5"] = "LEVEL 5";
	["SO_LEVEL_6"] = "LEVEL 6";
	["SO_LEVEL_7"] = "LEVEL 7";
	["SO_LEVEL_8"] = "LEVEL 8";
	["SO_LEVEL_9"] = "LEVEL 9";
	["SO_LEVEL_10"] = "LEVEL 10";
	["SO_LEVEL_11"] = "LEVEL 11";
	["SO_LEVEL_12"] = "LEVEL 12";
	["SO_LEVEL_13"] = "LEVEL 13";
	["SO_LEVEL_14"] = "LEVEL 14";
	["SO_LEVEL_15"] = "LEVEL 15";
	["SO_LEVEL_16"] = "LEVEL 16";
	["SO_LEVEL_17"] = "LEVEL 17";
	["SO_LEVEL_18"] = "LEVEL 18";
	["SO_LEVEL_19"] = "LEVEL 19";
	["SO_LEVEL_20"] = "LEVEL 20";
	["SO_LEVEL_21"] = "LEVEL 21";
	["SO_LEVEL_22"] = "LEVEL 22";
	["SO_LEVEL_23"] = "LEVEL 23";
	["SO_LEVEL_24"] = "LEVEL 24~";
	
	["SO_JMUSIC"] = "J-MUSIC";
	["SO_XROSS"] = "XROSS";
}

function RenameGroup( gName )
	local ReName = Renames[gName];
	if ( ReName ~= nil ) then
		return ReName;
	end;

	local cond = string.find( gName, "-" );
	local temp = "";
	local areAllNumbers = true;
	if cond ~= nil then
		for i=1,(cond-1) do
			if not IsANumber( StringAt(gName,i) ) then
				areAllNumbers = false;
			end;
		end;
		if areAllNumbers then
			temp = string.sub( gName , cond+1 );
			return temp;
		end;
		return gName;
	else
		return gName;
	end;
end;

--///////////////////////////////////////////////////////////////////////////////////////////////////
