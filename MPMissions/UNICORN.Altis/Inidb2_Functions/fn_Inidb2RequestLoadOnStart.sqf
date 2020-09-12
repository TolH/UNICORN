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
		private _random_FirstSpawn_Zone = 
			[
				"respawn_resistance_1","respawn_resistance_2","respawn_resistance_3","respawn_resistance_4","respawn_resistance_5",
				"respawn_resistance_6","respawn_resistance_7","respawn_resistance_8","respawn_resistance_9","respawn_resistance_10","respawn_resistance_11",
				"respawn_resistance_12","respawn_resistance_13","respawn_resistance_14","respawn_resistance_15","respawn_resistance_16","respawn_resistance_17",
				"respawn_resistance_18","respawn_resistance_19","respawn_resistance_20","respawn_resistance_21"
			] call BIS_fnc_selectRandom;
		private _rspPos = getMarkerPos _random_FirstSpawn_Zone;
		private _Ravage_starting_Foods_Items1 = ["rvg_purificationTablets","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_plasticBottlePurified","rvg_canteen","rvg_spirit","rvg_franta"] call BIS_fnc_selectRandom;
		private _Ravage_starting_Foods_Items2 = ["rvg_purificationTablets","rvg_beans","rvg_bacon","rvg_milk","rvg_rice","rvg_plasticBottlePurified","rvg_canteen","rvg_spirit","rvg_franta"] call BIS_fnc_selectRandom;
		player setUnitLoadout [[],[],[],["U_IG_Guerilla1_1",[[""],["rvg_Geiger",1,1],["rvg_canOpener",1,1],[_Ravage_starting_Foods_Items1,1,1],[_Ravage_starting_Foods_Items2,1,1]]],[],[],"","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]];
		player setPosATL _rspPos;
		player setDir round(random 360);
		player switchCamera "EXTERNAL";
		CurrentMoneyAmount = 5000;
		[[0.65, 1, 0.2, 0.15], 1.0, true, 5000] call BRG_fnc_Activate_GUI_MONEY;
		titleFadeOut 5;
		player setVariable ["GeigerON", true];
		playSound ["Beep_Target", false];
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
		_readThirst = _ppacket select 5;
		_readHunger = _ppacket select 6;
		_readRadiation = _ppacket select 7;
		_passtheparcel = 
		[
			_readpos,
			_readdir,
			_readdamage,
			_readloadout,
			_readCurrentmoney,
			_readThirst,
			_readHunger,
			_readRadiation
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
			"_readCurrentmoney",
			"_readThirst",
			"_readHunger",
			"_readRadiation"
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
		player setVariable ["thirst", _readThirst, false];
		player setVariable ["hunger", _readHunger, false];
		player setVariable ["radiation", _readRadiation, false];
		CurrentMoneyAmount = _readCurrentmoney;
		[[0.65, 1, 0.2, 0.15], 1.0, true, _readCurrentmoney] call BRG_fnc_Activate_GUI_MONEY;
		un_database_load = nil;
		//publicVariable "un_database_load";
		hint "Character loaded Successfully";
		player switchCamera "EXTERNAL";
		titleFadeOut 5;
		player setVariable ["GeigerON", true];
		playSound ["Beep_Target", false];
		//============================================//
	};
///============================================////============================================//