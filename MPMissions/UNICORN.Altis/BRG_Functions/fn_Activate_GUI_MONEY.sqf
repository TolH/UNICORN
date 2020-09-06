//============================================//
// Usage:  [[0.4, 0.5, 0.2, 0.15], 1.0, true, "Hello, World!", 0] call BRG_fnc_Activate_GUI_MONEY;
// Parameters: Position, Scale, Enabled, Text, Request
//============================================//
params ["_pos", "_scl", "_enb", "_txt"];
//============================================//
	//DELETE FRAME IF ALREADY ACTIVE
	private _ctl = (findDisplay 46) displayCtrl 501;
	ctrlDelete _ctl;
	disableSerialization;	
	private _ctl = (findDisplay 46) ctrlCreate ["RscStructuredText", 501];
	_ctl ctrlSetStructuredText (parseText format [
		"<img align='center' size='%2' color='%1' image='%3'/><br/><t align='center' size='%2' color='%1' shadow='2' shadowColor='#0000ff' shadowOffset='0.06'>%4</t>",
		["#66ffffff", "#ffffffff"] select _enb, 1, "Icons\money.jpg", _txt]); 
	_ctl ctrlSetPosition _pos;
	_ctl ctrlSetScale _scl;
	_ctl ctrlEnable _enb;
	_ctl ctrlCommit 0;