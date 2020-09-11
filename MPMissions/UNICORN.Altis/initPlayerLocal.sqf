//============================================//
titleText ["", "BLACK", 0];//titleFadeOut 3;
waitUntil {time > 1};
//CHECK IF INIDB DATABASE ALREADY EXIST TO LOAD SAVED DATA IF ANY
	[] call INIDB2_fnc_Inidb2RequestLoadOnStart;
//VARS FOR DRAW3D HANDLER ("Killed","Hit") AND MORE.
	NewMoneyAmount = 0;
	NewHitAmount = 0;
	PARACHUTE_IN_USE = 0;
	ABILITY_COOLDOWN_SJUMP_ACTIVE = 0;
	PLAYERISBUILDING = 0;
	PLAYEROBJECTMOVE = 0;
	PLAYEROBJECTCANCEL = 0;
//NAMEPLATE AND MISC TO BE ADDED
	//addMissionEventHandler ["Draw3D", {[3200] call BRG_fnc_StartCustomNameplate;}];
//ACTIVATE SJUMP GUI
	[[0.6, 1, 0.2, 0.15], 1.0, true, "5", 0] call BRG_fnc_Activate_GUI_SJUMP;
//ACTIVATE GUI HIT VISUAL NUMBER
	[player, 1] call BRG_fnc_Set_Killed_Hit_HANDLER;
//============================================//