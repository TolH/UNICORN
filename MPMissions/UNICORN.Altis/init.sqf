//=========================================================//
waituntil {!(IsNull (findDisplay 46))};
//INIDB SAVE
	SAVE_progress_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ( (_this select 1) == 10 ) then { [] call INIDB2_fnc_Inidb2RequestSavePlayer; };"];
//ACTIVATE PARACHUTE
	activate_PARACHUTE_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", " if ( ((_this select 1) == 57) && (!(isTouchingGround player)) && ((position player select 2) >= 4) ) then { [] call BRG_fnc_COD_Parachute; }; "];
//USE S-JUMP ABILITY
	activate_GUI_SJUMP_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ( (_this select 1) == 6 ) then { [[0.6, 1, 0.2, 0.15], 1.0, true, ""5"", 1] call BRG_fnc_Activate_GUI_SJUMP; };"];
//BuildCurrent Object
	TTB_BUILD_OBJECT_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ( ((_this select 1) == 57) && (PLAYERISBUILDING == 1) ) then { PLAYERISBUILDING = 0; };"];
//=========================================================//
