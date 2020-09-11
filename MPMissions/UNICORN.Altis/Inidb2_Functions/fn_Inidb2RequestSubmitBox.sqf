///============================================//
//TO USE: [_playerTxt] call INIDB2_fnc_Inidb2RequestSubmitBox;
///============================================//
params ["_playerTxt"];
if (_playerTxt == "") exitWith { hint format ["ERROR: MISSING ""TEXT"" "]; };
	_dataplayrowner = clientOwner;
	_dataplayrname = profileName;
	_dataplayruid = getPlayerUID player;
	un_database_SubmitBox = 
	[
		_dataplayrowner,
		_dataplayrname,
		_dataplayruid,
		_playerTxt
	];
	publicVariableServer "un_database_SubmitBox";
	//============================================//
    "un_database_loadSubmitBox" addPublicVariableEventHandler 
	{
		private ["_ppacket"];
		_ppacket = _this select 1;
		_readServerResponse = _ppacket select 0;
		un_database_loadSubmitBox = 
		[
			_readServerResponse
		];
		//
		hint format["SERVER MSG:\n%1",_readServerResponse];
    };
///============================================//