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
	_dataplayrThirst = player getVariable ["thirst", 100];
	_dataplayrHunger = player getVariable ["hunger", 100];
	_dataplayrRadiation = player getVariable ["radiation", 100];
	un_database_save = 
	[
		_dataplayrname,
		_dataplayruid,
		_dataplayrpos,
		_dataplayrdir,
		_dataplayrdamage,
		_dataplayrloadout,
		_dataplayrThirst,
		_dataplayrHunger,
		_dataplayrRadiation
	];
	publicVariableServer "un_database_save";
	hint "Character Stats Saved!";
///============================================//