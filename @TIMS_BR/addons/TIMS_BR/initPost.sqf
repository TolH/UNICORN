//============================================////============================================//
	//WAIT 5 SECONDS BEFORE STARTING TIMS_BR AFTER A SERVER RESTART.
		uiSleep 5;
	//LOAD CONFIG
		config_script = [] execVM "TIMS_BR\config.sqf";
		waitUntil {scriptDone config_script};
		diag_log "=======================================================================";
		diag_log "-=TIMS_BR=-: CONFIG FILE LOADED!";
	//CHECK IF TIMS_BR ACTIVATED FROM CONFIG
		if (TIMS_BR_ACTIVATED isEqualTo 1) then
		{
	//CUSTOM MAP STUFF
			map_script = [] execVM "TIMS_BR\Map\LootPos.sqf";
			waitUntil {scriptDone map_script};
			diag_log "=======================================================================";
			diag_log "-=TIMS_BR=-: LOOT SPAWNED!";
			diag_log "-=TIMS_BR=-: ACTIVATED AND RUNNING!";
			diag_log "=======================================================================";
		};
	//CHECK IF CIVILLIAN ACTIVITY IS ACTIVATED
		if (TIMS_BR_CIVILLIAN isEqualTo 1) then
		{
			_nil = [] execVM "TIMS_BR\cos\cosInit.sqf";
			call compile preprocessFileLineNumbers "TIMS_BR\CommonLib\CommonLib.sqf";
			diag_log "=======================================================================";
			diag_log "-=TIMS_BR=-: CIVILIAN ACTIVITY Loaded!";
			diag_log "=======================================================================";
			diag_log "=======================================================================";
		};
//============================================////============================================//