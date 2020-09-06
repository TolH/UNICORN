///============================================////============================================//
///===========================//INIDBI2 DATABASE STUFF START HERE//============================//
///============================================////============================================//
waitUntil {time > 0};
//============================================//
//HANDLE NEW PLAYER AND PLAYER LOADING
    "un_database_check" addPublicVariableEventHandler 
	{
		private ["_packet"];
		_packet = _this select 1;
		_dataplayrowner = _packet select 0;
		_dataplayrname = _packet select 1;
		_dataplayruid = _packet select 2;
		_datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(Inidbi2-0908-BRG-ALTIS)", _dataplayrname, _dataplayruid];
		_datanamearrayBase = format ["(%1)_(%2)_(PlayerBase)_(Inidbi2-0908-BRG-ALTIS)", _dataplayrname, _dataplayruid];
		_databasename = _datanamearray;
		_databasenameBase = _datanamearrayBase;
		_dataNewUnitLoadout = [[],[],[],["U_IG_Guerilla1_1",[[""],[],[],[],[]]],[],[],"","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		_dataplayrpos = getMarkerPos "respawn_resistance";
		_dataplayrdir = round(random 360);
		_inidbiUN = ["new", _databasename] call OO_INIDBI;
		_inidbiUNBase = ["new", _databasenameBase] call OO_INIDBI;
		_databasefind = "exists" call _inidbiUN;
		if (!_databasefind) then 
		{
			["write", ["INFO", "Name", _dataplayrname]] call _inidbiUN;
			["write", ["INFO", "UID", _dataplayruid]] call _inidbiUN;
			["write", ["INFO", "Position", _dataplayrpos]] call _inidbiUN;
			["write", ["INFO", "Direction", _dataplayrdir]] call _inidbiUN;
			["write", ["INFO", "Health", 0]] call _inidbiUN;
			["write", ["GEAR", "Loadout", _dataNewUnitLoadout]] call _inidbiUN;
			["write", ["INFO", "Money", 0]] call _inidbiUN;
			["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
			["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
			//BASE BUILDING DB
			["write", ["INFO", "Name", _dataplayrname]] call _inidbiUNBase;
			["write", ["INFO", "UID", _dataplayruid]] call _inidbiUNBase;
			["write", ["BASE", "ObjectCount", 0]] call _inidbiUNBase;

			format ["NewRaider: Welcome (%1)!", _dataplayrname] remoteExec ["hint", 0];
		};
		if (_databasefind) then 
		{
			//SPAWN PLAYER BASE WHEN HE LOG IN THEN THE PLAYER AFTER
			_readObjectCount = ["read", ["BASE", "ObjectCount", ""]] call _inidbiUNBase;
			_readObjPosDel = ["read", ["1", "Position", []]] call _inidbiUNBase;
			private _deleteBaseObj = nearestObjects [_readObjPosDel, ["ALL"], 25];
			if (count _deleteBaseObj < _readObjectCount) then 
			{
				diag_log format ["-=========================TIMSBR diag_log BASE_SPAWNNED: (%1)-(%2)-(%3) =========================-", _dataplayruid, _dataplayrname, _readObjectCount];
				//SPAWN PLAYER BASE
				_indexNumber = 1;
				for "_x" from 1 to _readObjectCount do 
				{
					_readObjName = ["read", [_indexNumber, "ObjectName", ""]] call _inidbiUNBase;
					_readObjPos = ["read", [_indexNumber, "Position", []]] call _inidbiUNBase;
					_readObjDir = ["read", [_indexNumber, "Direction", ""]] call _inidbiUNBase;
					//CREATE PLAYER BASE
					private _objectPlayerBase = _readObjName createVehicle [0,0,0];
					_objectPlayerBase setPosWorld _readObjPos;
					_objectPlayerBase setDir _readObjDir;
					_indexNumber = _indexNumber +1;
				};
			};
			//HOW TO DELETE BASEBUILDING
			/*private _deleteBaseObj = nearestObjects [_readObjPosDel, ["ALL"], 50];
			diag_log format ["-=TIMSBR diag_log: %1, %2", count _deleteBaseObj, _deleteBaseObj];
			//if ((str _nObject select [1,1] == "R") && (count _deleteBaseObj == 1))  then {hint"123";};
			if (count _deleteBaseObj > 1) then 
			{
				//DELETE PLAYER BASE
				_readObjPos = ["read", ["1", "Position", []]] call _inidbiUNBase;
				{
					deleteVehicle _x;
				}forEach _deleteBaseObj;
			};*/
			//SEND PLAYER LAST SAVE INFO
			_readpos = ["read", ["INFO", "Position", []]] call _inidbiUN;   
			_readdir = ["read", ["INFO", "Direction", ""]] call _inidbiUN;
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
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(Inidbi2-0908-BRG-ALTIS)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["INFO", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["INFO", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _packet select 5]] call _inidbiUN;
    };
//============================================//
//HANDLE KILLED PLAYER, RESET TO DEFAULT LOADOUT
    "un_database_ResetData" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(Inidbi2-0908-BRG-ALTIS)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
		_dataNewUnitLoadout = [[],[],[],["U_IG_Guerilla1_1",[[""],[],[],[],[]]],[],[],"","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["INFO", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["INFO", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _dataNewUnitLoadout]] call _inidbiUN;
    };
//============================================//
//HANDLE PLAYER MONEY ADDED AND REMOVED
    "un_database_saveMoney" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
		_dataplayrowner = _packet select 0;
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(Inidbi2-0908-BRG-ALTIS)", _packet select 1, _packet select 2];
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
			//SEND MONEY INFO BACK TO PLAYER
			un_database_loadMoney = 
			[
				_readcurmoney
			];
			_dataplayrowner publicVariableClient "un_database_loadMoney";
		};
	};
//============================================//
//HANDLE SAVE PLAYER BASEBUILDING
    "un_database_savePlayerBase" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
		_dataplayrowner = _packet select 0;
        _datanamearray = format ["(%1)_(%2)_(PlayerBase)_(Inidbi2-0908-BRG-ALTIS)", _packet select 1, _packet select 2];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
		_ReadObjectCount = ["read", ["BASE", "ObjectCount", ""]] call _inidbiUN;
        ["write", ["INFO", "Name", _packet select 1]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 2]] call _inidbiUN;
        ["write", [_ReadObjectCount +1, "ObjectName", _packet select 3]] call _inidbiUN;
        ["write", [_ReadObjectCount +1, "Position", _packet select 4]] call _inidbiUN;
        ["write", [_ReadObjectCount +1, "Direction", _packet select 5]] call _inidbiUN;
		//ADD NEW OBJECTS COUNT TO KEEP TRACK
		["write", ["BASE", "ObjectCount", _ReadObjectCount +1]] call _inidbiUN;
    };
//============================================//