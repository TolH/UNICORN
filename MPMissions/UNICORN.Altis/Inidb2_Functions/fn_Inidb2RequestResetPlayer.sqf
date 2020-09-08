///============================================////============================================//
///REQUEST TO THE SERVER FOR RESETING DATA BECAUSE THE PLAYER DIED
//TO USE: [] call INIDB2_fnc_Inidb2RequestResetPlayer;
///============================================//
	_dataplayrname = profileName;
	_dataplayruid = getPlayerUID player;
	_dataplayrpos = getMarkerPos "respawn_resistance";
	_dataplayrdir = round(random 360);
	un_database_ResetData = 
	[
		_dataplayrname,
		_dataplayruid,
		_dataplayrpos,
		_dataplayrdir
	];
	publicVariableServer "un_database_ResetData";
///============================================////============================================//