//EXEMPLE: [10] execVM "Tims_Functions\fn_Activate_GUI_SJUMP\SJUMP_COOLDOWN.sqf";
private _cooldownTIME = _this select 0;
	while {_cooldownTIME >= 1} do 
	{
		_cooldownTIME = _cooldownTIME - 1;
		uiSleep 1;
	};
	[[0.6, 1, 0.2, 0.15], 1.0, true, "5", 2] call BRG_fnc_Activate_GUI_SJUMP;