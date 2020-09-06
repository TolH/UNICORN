//============================================//
// Usage:  [[0.4, 0.5, 0.2, 0.15], 1.0, true, "Hello, World!", 0] call BRG_fnc_Activate_GUI_SJUMP;
// Parameters: Position, Scale, Enabled, Text, Request
//============================================//
params ["_pos", "_scl", "_enb", "_txt", "_request"];
//============================================//
	//CHECK IF PLAYER REQUESTED ABILITY ACTIVATION
	if (_request == 0) then 
	{
		//DELETE FRAME IF ALREADY ACTIVE
		private _ctl = (findDisplay 46) displayCtrl 500;
		ctrlDelete _ctl;
		disableSerialization;	
		private _ctl = (findDisplay 46) ctrlCreate ["RscStructuredText", 500];
		_ctl ctrlSetStructuredText (parseText format [
			"<img align='center' size='%2' color='%1' image='%3'/><br/><t align='center' size='%2' color='%1' shadow='2' shadowColor='#0000ff' shadowOffset='0.06'>%4</t>",
			["#66ffffff", "#ffffffff"] select _enb, 1, "Icons\jump_icon1.jpg", _txt]); 
		_ctl ctrlSetPosition _pos;
		_ctl ctrlSetScale _scl;
		_ctl ctrlEnable _enb;
		_ctl ctrlCommit 0;
	};
	//CHECK IF PLAYER REQUESTED ABILITY ACTIVATION
	if ((_request == 1) && (isTouchingGround player) && (ABILITY_COOLDOWN_SJUMP_ACTIVE == 0)) then 
	{
		ABILITY_COOLDOWN_SJUMP_ACTIVE = 1;
		//DELETE FRAME IF ALREADY ACTIVE
		private _ctl = (findDisplay 46) displayCtrl 500;
		ctrlDelete _ctl;
		//CREATE ICON
		disableSerialization;	
		private _ctl = (findDisplay 46) ctrlCreate ["RscStructuredText", 500];
		_ctl ctrlSetStructuredText (parseText format [
			"<img align='center' size='%2' color='%1' image='%3'/><br/><t align='center' size='%2' color='%1' shadow='2' shadowColor='#0000ff' shadowOffset='0.06'>%4</t>",
			["#66ffffff", "#ffffffff"] select _enb, 1, "Icons\jump_icon2.jpg", _txt]); 
		_ctl ctrlSetPosition _pos;
		_ctl ctrlSetScale _scl;
		_ctl ctrlEnable _enb;
		_ctl ctrlCommit 0;
		//MAKE PLAYER JUMP
		private _vel = velocity player; 
		private _dir = direction player; 
		private _speed = 50; 
		player setVelocity [ 
		(_vel select 0) + (sin _dir * _speed),  
		(_vel select 1) + (cos _dir * _speed),  
		50 
		];
		playSound "SJUMP";
		//START ABILITY COOLDOWN
		[30] execVM "BRG_Functions\GUI_SCRIPTS\SJUMP_COOLDOWN.sqf";
	};
	//CHECK IF PLAYER REQUESTED ABILITY RESET OFF COOLDOWN
	if (_request == 2) then 
	{
		//DELETE FRAME IF ALREADY ACTIVE
		private _ctl = (findDisplay 46) displayCtrl 500;
		ctrlDelete _ctl;
		disableSerialization;	
		private _ctl = (findDisplay 46) ctrlCreate ["RscStructuredText", 500];
		_ctl ctrlSetStructuredText (parseText format [
			"<img align='center' size='%2' color='%1' image='%3'/><br/><t align='center' size='%2' color='%1' shadow='2' shadowColor='#0000ff' shadowOffset='0.06'>%4</t>",
			["#66ffffff", "#ffffffff"] select _enb, 1, "Icons\jump_icon1.jpg", _txt]); 
		_ctl ctrlSetPosition _pos;
		_ctl ctrlSetScale _scl;
		_ctl ctrlEnable _enb;
		_ctl ctrlCommit 0;
		ABILITY_COOLDOWN_SJUMP_ACTIVE = 0;
	};