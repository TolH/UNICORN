///============================================////============================================//
///SEND NAME AND UID TO SERVER TO CHECK FOR DATABASE
//TO USE: [] call INIDB2_fnc_Inidb2RequestLoadOnStart;
///============================================//
    if (!isNil "un_database_check") then { un_database_check = nil };
    uiSleep 1;
    if (isNil "un_database_check") then 
	{
		_dataplayrowner = clientOwner;
		_dataplayrname = profileName;
		_dataplayruid = getPlayerUID player;
		un_database_check = 
		[
			_dataplayrowner,
			_dataplayrname,
			_dataplayruid
		];
		publicVariableServer "un_database_check";
		player setUnitLoadout [[],[],[],["U_IG_Guerilla1_1",[[""],[],[],[],[]]],[],[],"","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		player switchCamera "EXTERNAL";
		[[0.65, 1, 0.2, 0.15], 1.0, true, 5000] call BRG_fnc_Activate_GUI_MONEY;
		CurrentMoneyAmount = 0;
		titleFadeOut 5;
    };
///============================================//
///SERVER FOUND PLAYER DATABASE AND NOW SENT US THE DATA TO LOAD//============================================//
///============================================//
    "un_database_load" addPublicVariableEventHandler 
	{
		private ["_ppacket"];
		_ppacket = _this select 1;
		_readpos = _ppacket select 0;
		_readdir = _ppacket select 1;
		_readdamage = _ppacket select 2;
		_readloadout = _ppacket select 3;
		_readCurrentmoney = _ppacket select 4;
		_passtheparcel = 
		[
			_readpos,
			_readdir,
			_readdamage,
			_readloadout,
			_readCurrentmoney
		];
		_Null = _passtheparcel call FN_loaddata;
    };
///============================================//
///LOAD PLAYER DATA IF ANY FOUND//============================================//
///============================================//
    FN_loaddata = 
	{
		params 
		[
			"_readpos",
			"_readdir",
			"_readdamage",
			"_readloadout",
			"_readCurrentmoney"
		];
		//============================================//
		//Clear player gear
		removeAllAssignedItems player;
		removeAllItems player;
		clearAllItemsFromBackpack player;
		removeBackpack player;
		removeUniform player;
		removeVest player;
		removeHeadgear player;
		removeGoggles player;
		removeAllWeapons player;
		removeAllPrimaryWeaponItems player;
		removeAllHandgunItems player;
		//============================================//
		//Add player gear from ServerDB
		player setPosATL _readpos;
		player setDir _readdir;
		player setDammage _readdamage;
		player setUnitLoadout _readloadout;
		[[0.65, 1, 0.2, 0.15], 1.0, true, _readCurrentmoney] call BRG_fnc_Activate_GUI_MONEY;
		CurrentMoneyAmount = _readCurrentmoney;
		un_database_load = nil;
		publicVariable "un_database_load";
		hint "Character loaded Successfully";
		player switchCamera "EXTERNAL";
		titleFadeOut 5;
		//============================================//
	};
///============================================////============================================//