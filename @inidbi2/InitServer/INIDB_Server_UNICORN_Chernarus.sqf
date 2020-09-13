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
		_datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(UNICORN-CHERNARUSREDUX)", _dataplayrname, _dataplayruid];
		_datanamearrayBase = format ["(%1)_(%2)_(PlayerBase)_(UNICORN-CHERNARUSREDUX)", _dataplayrname, _dataplayruid];
		_databasename = _datanamearray;
		_databasenameBase = _datanamearrayBase;
		_Ravage_starting_Foods_Items1 = ["rvg_purificationTablets","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_plasticBottlePurified","rvg_canteen","rvg_spirit","rvg_franta"] call BIS_fnc_selectRandom;
		_Ravage_starting_Foods_Items2 = ["rvg_purificationTablets","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_plasticBottlePurified","rvg_canteen","rvg_spirit","rvg_franta"] call BIS_fnc_selectRandom;
		_dataNewUnitLoadout = [[],[],[],["U_IG_Guerilla1_1",[[""],["rvg_Geiger",1,1],["rvg_canOpener",1,1],[_Ravage_starting_Foods_Items1,1,1],[_Ravage_starting_Foods_Items2,1,1]]],[],[],"","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		_dataplayrpos = getMarkerPos "respawn_resistance";
		_dataplayrdir = round(random 360);
		_inidbiUN = ["new", _databasename] call OO_INIDBI;
		_inidbiUNBase = ["new", _databasenameBase] call OO_INIDBI;
		_databasefind = "exists" call _inidbiUN;
		if (!_databasefind) then 
		{
			["write", ["INFO", "Name", _dataplayrname]] call _inidbiUN;
			["write", ["INFO", "UID", _dataplayruid]] call _inidbiUN;
			["write", ["INFO", "Level", 1]] call _inidbiUN;
			["write", ["INFO", "XP", 0]] call _inidbiUN;
			["write", ["INFO", "Position", _dataplayrpos]] call _inidbiUN;
			["write", ["INFO", "Direction", _dataplayrdir]] call _inidbiUN;
			["write", ["INFO", "Health", 0]] call _inidbiUN;
			["write", ["INFO", "Money", 5000]] call _inidbiUN;
			["write", ["GEAR", "Loadout", _dataNewUnitLoadout]] call _inidbiUN;
			["write", ["RAVAGE", "Thirst", 100]] call _inidbiUN;
			["write", ["RAVAGE", "Hunger", 100]] call _inidbiUN;
			["write", ["RAVAGE", "Radiation", 0]] call _inidbiUN;
			//BASE BUILDING DB
			["write", ["INFO", "Name", _dataplayrname]] call _inidbiUNBase;
			["write", ["INFO", "UID", _dataplayruid]] call _inidbiUNBase;
			["write", ["BASE", "ObjectCount", 0]] call _inidbiUNBase;
			["write", ["0", "ObjectName", "template"]] call _inidbiUNBase;
			["write", ["0", "Position", [0,0,0]]] call _inidbiUNBase;
			["write", ["0", "Direction", 0]] call _inidbiUNBase;
			format ["NewRaider: Welcome (%1)!", _dataplayrname] remoteExec ["hint", 0];
		};
		if (_databasefind) then 
		{
			//SPAWN PLAYER BASE WHEN HE LOG IN IF NOT ALREADY SPAWNED
			_readObjectCount = ["read", ["BASE", "ObjectCount", ""]] call _inidbiUNBase;
			//CHECK IF PLAYER HAS A BASE FIRST
			if (_readObjectCount >= 1) then 
			{
				_readObjPos = ["read", ["1", "Position", []]] call _inidbiUNBase;
				_AllBaseObj = nearestObjects [[_readObjPos select 0, _readObjPos select 1, 0], ["ALL"], 25];//RANGE HERE TO BE MODIFIED DEPENDING ON PLAYER LEVEL
				//SPAWN BASE IF CURRENT OBJECT NUMBER DOESNT MATCHES THE NUMBER IN DATABASE COUNT: NOT GOOD NEED BETTER OPTION
				if (count _AllBaseObj < _readObjectCount) then 
				{
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
					diag_log format ["-=========================TIMSBR diag_log SPAWNING_BASE_INFO: (%1)-(%2)- BASE SIZE:(%3) =========================-", _dataplayruid, _dataplayrname, _readObjectCount];
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
				};
			};
			//SEND PLAYER LAST SAVE INFO
			_readpos = ["read", ["INFO", "Position", []]] call _inidbiUN;   
			_readdir = ["read", ["INFO", "Direction", ""]] call _inidbiUN;
			_readdamage = ["read", ["INFO", "Health", ""]] call _inidbiUN;
			_readloadout = ["read", ["GEAR", "Loadout", []]] call _inidbiUN;
			_readCurrentmoney = ["read", ["INFO", "Money", ""]] call _inidbiUN;
			_readThirst = ["read", ["RAVAGE", "Thirst", ""]] call _inidbiUN;
			_readHunger = ["read", ["RAVAGE", "Hunger", ""]] call _inidbiUN;
			_readRadiation = ["read", ["RAVAGE", "Radiation", ""]] call _inidbiUN;
			_readcurLevel = ["read", ["INFO", "Level", ""]] call _inidbiUN;
			_readcurXP = ["read", ["INFO", "XP", ""]] call _inidbiUN;
			un_database_load = 
			[
				_readpos,
				_readdir,
				_readdamage,
				_readloadout,
				_readCurrentmoney,
				_readThirst,
				_readHunger,
				_readRadiation,
				_readcurLevel,
				_readcurXP
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
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(UNICORN-CHERNARUSREDUX)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["INFO", "Position", _packet select 2]] call _inidbiUN;
        ["write", ["INFO", "Direction", _packet select 3]] call _inidbiUN;
        ["write", ["INFO", "Health", _packet select 4]] call _inidbiUN;
        ["write", ["GEAR", "Loadout", _packet select 5]] call _inidbiUN;
		["write", ["RAVAGE", "Thirst", _packet select 6]] call _inidbiUN;
		["write", ["RAVAGE", "Hunger", _packet select 7]] call _inidbiUN;
		["write", ["RAVAGE", "Radiation", _packet select 8]] call _inidbiUN;
    };
//============================================//
//HANDLE KILLED PLAYER, RESET TO DEFAULT LOADOUT
    "un_database_ResetData" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(UNICORN-CHERNARUSREDUX)", _packet select 0, _packet select 1];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
		_Ravage_starting_Foods_Items1 = ["rvg_purificationTablets","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_plasticBottlePurified","rvg_canteen","rvg_spirit","rvg_franta"] call BIS_fnc_selectRandom;
		_Ravage_starting_Foods_Items2 = ["rvg_purificationTablets","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_plasticBottlePurified","rvg_canteen","rvg_spirit","rvg_franta"] call BIS_fnc_selectRandom;
		_dataNewUnitLoadout = [[],[],[],["U_IG_Guerilla1_1",[[""],["rvg_Geiger",1,1],["rvg_canOpener",1,1],[_Ravage_starting_Foods_Items1,1,1],[_Ravage_starting_Foods_Items2,1,1]]],[],[],"","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		_random_Spawn_Zone = 
			[
				"respawn_resistance_1","respawn_resistance_2","respawn_resistance_3","respawn_resistance_4","respawn_resistance_5",
				"respawn_resistance_6","respawn_resistance_7","respawn_resistance_8","respawn_resistance_9","respawn_resistance_10","respawn_resistance_11",
				"respawn_resistance_12","respawn_resistance_13","respawn_resistance_14","respawn_resistance_15","respawn_resistance_16","respawn_resistance_17",
				"respawn_resistance_18","respawn_resistance_19","respawn_resistance_20","respawn_resistance_21"
			] call BIS_fnc_selectRandom;
		_dataplayrpos = getMarkerPos _random_Spawn_Zone;
		_dataplayrdir = round(random 360);
        ["write", ["INFO", "Name", _packet select 0]] call _inidbiUN;
        ["write", ["INFO", "UID", _packet select 1]] call _inidbiUN;
        ["write", ["INFO", "Position", _dataplayrpos]] call _inidbiUN;
        ["write", ["INFO", "Direction", _dataplayrdir]] call _inidbiUN;
        ["write", ["INFO", "Health", 0]] call _inidbiUN;
		["write", ["RAVAGE", "Thirst", 100]] call _inidbiUN;
		["write", ["RAVAGE", "Hunger", 100]] call _inidbiUN;
		["write", ["RAVAGE", "Radiation", 0]] call _inidbiUN;
		["write", ["GEAR", "Loadout", _dataNewUnitLoadout]] call _inidbiUN;
    };
//============================================//
//HANDLE PLAYER MONEY ADDED AND REMOVED
    "un_database_saveMoneyLvlXp" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
		_dataplayrowner = _packet select 0;
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(UNICORN-CHERNARUSREDUX)", _packet select 1, _packet select 2];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
		_readcurmoney = ["read", ["INFO", "Money", ""]] call _inidbiUN;
		_newmoneyamount = _readcurmoney + (_packet select 3);
		_readcurLevel = ["read", ["INFO", "Level", ""]] call _inidbiUN;
		_readcurXP = ["read", ["INFO", "XP", ""]] call _inidbiUN;
		_newXPamount = _readcurXP + (_packet select 4);
		//FOR MONEY STUFF
		if (_newmoneyamount >= 0) then 
		{
			["write", ["INFO", "Name", _packet select 1]] call _inidbiUN;
			["write", ["INFO", "UID", _packet select 2]] call _inidbiUN;
			["write", ["INFO", "Money", _newmoneyamount]] call _inidbiUN;
			["write", ["INFO", "XP", _newXPamount]] call _inidbiUN;
			_readcurmoney = ["read", ["INFO", "Money", ""]] call _inidbiUN;
			_readcurXP = ["read", ["INFO", "XP", ""]] call _inidbiUN;
			diag_log format ["-=TIMSBR diag_log: (%1)-(%2) ACTIVATED MONEY FUNCTION WITH: (%3)$  TOTAL MONEY: (%4)$ XP: (%5)=-", _packet select 2, _packet select 1, _packet select 3, _readcurmoney, _readcurXP];
			//SEND MONEY INFO BACK TO PLAYER
			un_database_loadMoneyLvlXp = 
			[
				_readcurmoney,
				_readcurXP,
				_readcurLevel
			];
			_dataplayrowner publicVariableClient "un_database_loadMoneyLvlXp";
		};
	};
//============================================//
//HANDLE SAVE PLAYER BASEBUILDING
    "un_database_savePlayerBase" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
		_dataplayrowner = _packet select 0;
        _datanamearray = format ["(%1)_(%2)_(PlayerBase)_(UNICORN-CHERNARUSREDUX)", _packet select 1, _packet select 2];
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
//HANDLE PLAYER SUBMIT BOX MSG RECEIVED
    "un_database_SubmitBox" addPublicVariableEventHandler 
	{
		private ["_packet"];
        _packet = _this select 1;
		_dataplayrowner = _packet select 0;
		_dataplayerMSG = _packet select 3;
        _datanamearray = format ["(%1)_(%2)_(PlayerInfo)_(UNICORN-CHERNARUSREDUX)", _packet select 1, _packet select 2];
        _databasename = _datanamearray;
        _inidbiUN = ["new", _databasename] call OO_INIDBI;
		_SendServerResponse = ["read", ["INFO", "Name", _packet select 1]] call _inidbiUN;
		diag_log format ["-===========TIMSBR SUBMITBOX: (%1)_(%2) ***%3***",_packet select 1, _packet select 2, _dataplayerMSG];
		//SEND SERVER MSG BACK TO PLAYER
		un_database_loadSubmitBox = 
		[
			_SendServerResponse
		];
		_dataplayrowner publicVariableClient "un_database_loadSubmitBox";
	};
//============================================//