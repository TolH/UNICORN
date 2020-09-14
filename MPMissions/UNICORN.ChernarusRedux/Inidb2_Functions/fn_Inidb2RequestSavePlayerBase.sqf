///============================================//
///REQUEST TO THE SERVER FOR SAVING PLAYER BASE BUILDING DATA
//TO USE: [_object] call INIDB2_fnc_Inidb2RequestSavePlayerBase;
///============================================//
private ["_dataObject"];
_dataObject = _this select 0;
_dataObjectName = typeOf _dataObject;
_dataplayrowner = clientOwner;
_dataPlayrName = profileName;
_dataPlayrUID = getPlayerUID player;
_dataObjectPos = getPosWorld _dataObject;
_dataObjectDir = direction _dataObject;
	un_database_savePlayerBase = 
	[
		_dataplayrowner,
		_dataPlayrName,
		_dataPlayrUID,
		_dataObjectName,
		_dataObjectPos,
		_dataObjectDir
	];
	publicVariableServer "un_database_savePlayerBase";
///============================================//