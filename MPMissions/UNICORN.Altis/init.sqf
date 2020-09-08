//=========================================================//
waituntil {!(IsNull (findDisplay 46))};
//=========================================================//
MAIN_KeyDown_handler = findDisplay 46 displayAddEventHandler ["KeyDown", {
    _source  = _this select 0;
    _keyCode = _this select 1;
    _isShift = _this select 2;
    _isCtrl  = _this select 3;
    _isAlt   = _this select 4;
    //INIDB SAVE
    if (_keyCode == 10) exitWith {
        [] call INIDB2_fnc_Inidb2RequestSavePlayer;
    };
	//ACTIVATE PARACHUTE
    if ((_keyCode == 57) && (!(isTouchingGround player)) && ((position player select 2) >= 4)) exitWith {
        [] call BRG_fnc_COD_Parachute;
    };
	//USE S-JUMP ABILITY
    if (_keyCode == 6) exitWith {
        [[0.6, 1, 0.2, 0.15], 1.0, true, "5", 1] call BRG_fnc_Activate_GUI_SJUMP;
    };
	//BuildCurrent Object
    if ((_keyCode == 57) && (PLAYERISBUILDING == 1)) exitWith {
        playSound "BUILDSFX";
		PLAYERISBUILDING = 0;
    };
	//MOVE OBJECT UP WITH ARROW KEY UP
    if ((_keyCode == 200) && (PLAYERISBUILDING == 1)) exitWith {
		PLAYEROBJECTMOVE = 1;
    };
	//MOVE OBJECT DOWN WITH ARROW KEY DOWN
    if ((_keyCode == 208) && (PLAYERISBUILDING == 1)) exitWith {
		PLAYEROBJECTMOVE = 2;
    };
	//MOVE OBJECT ROTATE LEFT
    if ((_keyCode == 203) && (PLAYERISBUILDING == 1)) exitWith {
		PLAYEROBJECTMOVE = 3;
    };
	//MOVE OBJECT ROTATE RIGHT
    if ((_keyCode == 205) && (PLAYERISBUILDING == 1)) exitWith {
		PLAYEROBJECTMOVE = 4;
    };
	//CANCEL CURRENT OBJECT
    if ((_keyCode == 1) && (PLAYERISBUILDING == 1)) exitWith {
		PLAYEROBJECTCANCEL = 1;
    };
}];
/*
findDisplay 46 displayAddEventHandler ["KeyDown", {
    _source  = _this select 0;
    _keyCode = _this select 1;
    _isShift = _this select 2;
    _isCtrl  = _this select 3;
    _isAlt   = _this select 4;
    
    if (_keyCode isEqualTo 44 && _isCtrl) exitWith {
        //your code
    };
    if (_keyCode isEqualTo 44 && _isCtrl) exitWith {
        //your code
    };
}];
*/