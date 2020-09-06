///============================================//
///REQUEST TO THE SERVER FOR SAVING PLAYER PROGRESS DATA
//TO USE: [500] call INIDB2_fnc_Inidb2RequestSaveMoney;
///============================================//
params ["_MoneyAdded"];
if (isNil "_MoneyAdded") exitWith { hint format ["ERROR: MISSING [VALUES]"]; };
	_dataplayrowner = clientOwner;
	_dataplayrname = profileName;
	_dataplayruid = getPlayerUID player;
	un_database_saveMoney = 
	[
		_dataplayrowner,
		_dataplayrname,
		_dataplayruid,
		_MoneyAdded
	];
	publicVariableServer "un_database_saveMoney";
	if (_MoneyAdded == 0) then { } else { hint format ["%1 $", _MoneyAdded]; };
	//hint format ["%1 $", _MoneyAdded];
	//hintCadet format ["%1 \n%1", _MoneyAdded];
	//============================================//
	//SERVER SENT BACK NEW PLAYER MONEY VALUE
    "un_database_loadMoney" addPublicVariableEventHandler 
	{
		private ["_ppacket"];
		_ppacket = _this select 1;
		_readcurmoney = _ppacket select 0;
		_un_database_loadMoney = 
		[
			_readcurmoney
		];
		//
		publicVariable "un_database_loadMoney";
		[[0.65, 1, 0.2, 0.15], 1.0, true, _readcurmoney] call BRG_fnc_Activate_GUI_MONEY;
		CurrentMoneyAmount = _readcurmoney;
    };
///============================================//