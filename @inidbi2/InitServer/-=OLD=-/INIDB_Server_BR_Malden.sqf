///============================================////============================================//
///===========================//INIDBI2 DATABASE STUFF START HERE//============================//
///============================================////============================================//
waitUntil {time > 0};
//============================================//
    "un_database_check" addPublicVariableEventHandler 
	{
		private ["_packet"];
		_packet = _this select 1;
		_dataplayrowner = _packet select 0;
		_dataplayrname = _packet select 1;
		_dataplayruid = _packet select 2;
		_datanamearray = format ["(%1)_(%2)_(Inidbi2-BR-Malden)", _dataplayrname, _dataplayruid];
		_databasename = _datanamearray;
		_inidbiUN = ["new", _databasename] call OO_INIDBI;
		_databasefind = "exists" call _inidbiUN;
		if (!_databasefind) then 
		{
			["write", ["INFO", "Name", _dataplayrname]] call _inidbiUN;
			["write", ["INFO", "UID", _dataplayruid]] call _inidbiUN;
			["write", ["INFO", "Health", 0]] call _inidbiUN;
			["write", ["INFO", "Money", 0]] call _inidbiUN;
			//NEED TO ADD LOADOUT HERE TO FIX ERROR IF PLAYER DISCONNECT WITHOUT SAVING
			//
			format ["NewData: Welcome (%1)!", _dataplayrname] remoteExec ["hint", 0];
		};
		if (_databasefind) then 
		{
			_readpos = ["read", ["POSITION", "Position", []]] call _inidbiUN;   
			_readdir = ["read", ["POSITION", "Direction", ""]] call _inidbiUN;
			_readdamage = ["read", ["INFO", "Health", ""]] call _inidbiUN;
			_readloadout = ["read", ["GEAR", "Loadout", []]] call _inidbiUN;
			_readCurrentmoney = ["read", ["INFO", "Money", ""]] call _inidbiUN;
			un_database_load = 
			[
				_readpos,
				_readdir,
				_readdamage,
				_readloadout,
				_readCurrentmoney
			];
			_dataplayrowner publicVariableClient "un_database_load";
		};
		un_database_check = nil;
    };
//============================================//
//HANDLE NORMAL PLAYER SAVE
    "un_database_save" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
        _datanamearray = format ["(%1)_(%2)_(Inidbi2-BR-Malden)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["POSITION", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["POSITION", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _packet select 5]] call _inidbiUN;
    };
//============================================//
//HANDLE KILLED PLAYER, RESET TO DEFAULT
    "un_database_ResetData" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
        _datanamearray = format ["(%1)_(%2)_(Inidbi2-BR-Malden)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["POSITION", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["POSITION", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _packet select 5]] call _inidbiUN;
    };
//============================================//
//HANDLE PLAYER MONEY ADDED AND REMOVED
    "un_database_saveMoney" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
		_dataplayrowner = _packet select 0;
        _datanamearray = format ["(%1)_(%2)_(Inidbi2-BR-Malden)", _packet select 1, _packet select 2];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
		_readcurmoney = ["read", ["INFO", "Money", ""]] call _inidbiUN;
		_newmoneyamount = _readcurmoney + (_packet select 3);
		if (_newmoneyamount >= 0) then 
		{
			["write", ["INFO", "Name", _packet select 1]] call _inidbiUN;
			["write", ["INFO", "UID", _packet select 2]] call _inidbiUN;
			["write", ["INFO", "Money", _newmoneyamount]] call _inidbiUN;
			_readcurmoney = ["read", ["INFO", "Money", ""]] call _inidbiUN;
			diag_log format ["-=TIMSBR diag_log: (%1)-(%2) ACTIVATED MONEY FUNCTION WITH: (%3)$  TOTAL MONEY: (%4)$=-", _packet select 2, _packet select 1, _packet select 3, _readcurmoney];
			["-=TIMSBR BIS_fnc_logFormat: (%1)-(%2) ACTIVATED MONEY FUNCTION WITH: (%3)$  TOTAL MONEY: (%4)$=-", _packet select 2, _packet select 1, _packet select 3, _readcurmoney] call BIS_fnc_logFormat;
			un_database_loadMoney = 
			[
				_readcurmoney
			];
			_dataplayrowner publicVariableClient "un_database_loadMoney";
		};
	};
//============================================//