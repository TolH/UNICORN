///============================================////============================================//
///===========================//INIDBI2 DATABASE STUFF START HERE//============================//
///============================================////============================================//
waitUntil {time > 0};
///============================================//
///CHECKING THE DATABASE//============================================//
///============================================//
    "un_database_check" addPublicVariableEventHandler 
	{
		private ["_packet"];
		_packet = _this select 1;
		_dataplayrowner = _packet select 0;
		_dataplayrname = _packet select 1;
		_dataplayruid = _packet select 2;
		_datanamearray = format ["(%1)_(%2)_(TOLH-ALTIS-DAYZ-RAVAGE)", _dataplayrname, _dataplayruid];
		_databasename = _datanamearray;
		_inidbiUN = ["new", _databasename] call OO_INIDBI;
		_databasefind = "exists" call _inidbiUN;
		///============================================//
		///PLAYER NAME OR GUID DOESNT EXIST, CREATE DEFAULT DATA//============================================//
		///============================================//
		if (!_databasefind) then 
		{
			["write", ["INFO", "Name", _dataplayrname]] call _inidbiUN;
			["write", ["INFO", "UID", _dataplayruid]] call _inidbiUN;
			["write", ["INFO", "Health", 0]] call _inidbiUN;
			["write", ["INFO", "Thirst", 100]] call _inidbiUN;
			["write", ["INFO", "Hunger", 100]] call _inidbiUN;
			["write", ["INFO", "Radiation", 0]] call _inidbiUN;
			["write", ["INFO", "Currency", 0]] call _inidbiUN;
			//"Welcome to a hardcore survival server!" remoteExec ["hintSilent"];
			format ["Welcome to a hardcore survival server (%1)", _dataplayrname] remoteExec ["hint", 0];
		};
		///============================================//
		///FOUND THE DATABASE NOW LOADING DATA TO SEND TO PLAYER//============================================//
		///============================================//
		if (_databasefind) then 
		{
			_readpos = ["read", ["POSITION", "Position", []]] call _inidbiUN;   
			_readdir = ["read", ["POSITION", "Direction", ""]] call _inidbiUN;
			_readdamage = ["read", ["INFO", "Health", ""]] call _inidbiUN;
			_readloadout = ["read", ["GEAR", "Loadout", []]] call _inidbiUN;
			_readTHIRST = ["read", ["INFO", "Thirst", []]] call _inidbiUN;
			_readHUNGER = ["read", ["INFO", "Hunger", []]] call _inidbiUN;
			_readRADIATION = ["read", ["INFO", "Radiation", []]] call _inidbiUN;
			_readCURRENCY = ["read", ["INFO", "Currency", []]] call _inidbiUN;
			un_database_load = 
			[
				_readpos,
				_readdir,
				_readdamage,
				_readloadout,
				_readTHIRST,
				_readHUNGER,
				_readRADIATION,
				_readCURRENCY
			];
			_dataplayrowner publicVariableClient "un_database_load";
			"Character loaded." remoteExec ["hintSilent"];
		};
		un_database_check = nil;
    };
///============================================//
///PLAYER SENT SAVE GAME DATA TO SERVER - SAVING IT TO DATABASE//============================================//
///============================================//
	//HANDLE NORMAL PLAYER SAVE
    "un_database_save" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
        _datanamearray = format ["(%1)_(%2)_(TOLH-ALTIS-DAYZ-RAVAGE)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["POSITION", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["POSITION", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _packet select 5]] call _inidbiUN;
		["write", ["INFO", "Thirst", _packet select 6]] call _inidbiUN;
		["write", ["INFO", "Hunger", _packet select 7]] call _inidbiUN;
		["write", ["INFO", "Radiation", _packet select 8]] call _inidbiUN;
		["write", ["INFO", "Currency", _packet select 9]] call _inidbiUN;
        "Character Saved." remoteExec ["hintSilent"];
    };
	//HANDLE KILLED PLAYER, RESET TO DEFAULT
    "un_database_ResetData" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
        _datanamearray = format ["(%1)_(%2)_(TOLH-ALTIS-DAYZ-RAVAGE)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["POSITION", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["POSITION", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _packet select 5]] call _inidbiUN;
		["write", ["INFO", "Thirst", _packet select 6]] call _inidbiUN;
		["write", ["INFO", "Hunger", _packet select 7]] call _inidbiUN;
		["write", ["INFO", "Radiation", _packet select 8]] call _inidbiUN;
    };
///============================================//
///PLAYER SENT MONEY DATA TO SERVER - SAVING IT TO DATABASE//============================================//
///============================================//
	//HANDLE PLAYER MONEY
	"un_database_GiveMoney" addPublicVariableEventHandler 
	{
		
	};
///============================================////============================================//
///============================//INIDBI2 DATABASE STUFF STOP HERE//============================//
///============================================////============================================//