///============================================////============================================//
///REQUEST TO THE SERVER FOR RESETING DATA BECAUSE THE PLAYER DIED
//TO USE: [] call INIDB2_fnc_Inidb2RequestResetPlayer;
///============================================//
	_dataplayrname = profileName;
	_dataplayruid = getPlayerUID player;
	un_database_ResetData = 
	[
		_dataplayrname,
		_dataplayruid
	];
	publicVariableServer "un_database_ResetData";
///============================================////============================================//