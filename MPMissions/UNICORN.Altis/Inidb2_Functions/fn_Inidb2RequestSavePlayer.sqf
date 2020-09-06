///============================================//
///REQUEST TO THE SERVER FOR SAVING PLAYER PROGRESS DATA
//TO USE: [] call INIDB2_fnc_Inidb2RequestSavePlayer;
//TO USE: player addAction ["<t color='#38BAFF'>Save Game</t>", {[] call INIDB2_fnc_Inidb2RequestSavePlayer;}];
///============================================//
	_dataplayrname = profileName;
	_dataplayruid = getPlayerUID player;
	_dataplayrpos = getPosATL player;
	_dataplayrdir = direction player;
	_dataplayrdamage = damage player;
	_dataplayrloadout = getUnitLoadout player;
	un_database_save = 
	[
		_dataplayrname,
		_dataplayruid,
		_dataplayrpos,
		_dataplayrdir,
		_dataplayrdamage,
		_dataplayrloadout
	];
	publicVariableServer "un_database_save";
	hint "Character Saved!";
///============================================//