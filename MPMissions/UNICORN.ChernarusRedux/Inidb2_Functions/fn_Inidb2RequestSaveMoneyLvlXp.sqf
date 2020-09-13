///============================================//
///REQUEST TO THE SERVER FOR SAVING PLAYER MONEY\XP\LEVEL
//TO USE: [500, 100] call INIDB2_fnc_Inidb2RequestSaveMoneyLvlXp;
///============================================//
params ["_MoneyAdded","_XpAdded"];
if (isNil "_MoneyAdded") exitWith { hint format ["ERROR: MISSING [VALUES]"]; };
	_dataplayrowner = clientOwner;
	_dataplayrname = profileName;
	_dataplayruid = getPlayerUID player;
	un_database_saveMoneyLvlXp = 
	[
		_dataplayrowner,
		_dataplayrname,
		_dataplayruid,
		_MoneyAdded,
		_XpAdded
	];
	publicVariableServer "un_database_saveMoneyLvlXp";
	if (_MoneyAdded == 0) then { } else { hint format ["MONEY:%1 $\nXP:%2", _MoneyAdded, _XpAdded]; };

	//============================================//
	//SERVER SENT BACK NEW PLAYER MONEY\XP\LEVEL
    "un_database_loadMoneyLvlXp" addPublicVariableEventHandler 
	{
		private ["_ppacket"];
		_ppacket = _this select 1;
		_readcurmoney = _ppacket select 0;
		_readcurXP = _ppacket select 1;
		_readcurLevel = _ppacket select 2;
		_un_database_loadMoneyLvlXp = 
		[
			_readcurmoney,
			_readcurXP,
			_readcurLevel
		];
		//publicVariable "un_database_loadMoneyLvlXp";
		[[0.65, 1, 0.2, 0.15], 1.0, true, _readcurmoney] call BRG_fnc_Activate_GUI_MONEY;
		CurrentMoneyAmount = _readcurmoney;
    };
///============================================//