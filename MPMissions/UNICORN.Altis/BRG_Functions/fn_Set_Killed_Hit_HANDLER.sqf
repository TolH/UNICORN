//============================================//
//	TO USE: [_target, _request] call BRG_fnc_Set_Killed_Hit_HANDLER;
//============================================//
params ["_target","_request"];
//============================================//
//ADD "Hit" HANDLER
if ((_request == 1) || (_request == 3))  then 
{
	_target addEventHandler ["Hit", { 
		params ["_unit", "_source", "_damage", "_instigator"];
		//EXIT IF AI HITS THEMSELVES
		//if (_instigator == _unit) exitWith {};
		private _dir2 = random(360);
		private _speed2 = 2;
		private _NewDmgDone = round (_damage * 100);
		NewHitAmount = _NewDmgDone;
		private _Hit_GUI_Money = createVehicle ["Land_Matches_F", [getPosATL _unit select 0, getPosATL _unit select 1, (getPosATL _unit select 2)], [], 0, "CAN_COLLIDE"];
		_Hit_GUI_Money setPos (_unit modelToWorld [0,0,1]);
		_Hit_GUI_Money setVelocity [_speed2 * sin(_dir2), _speed2 * cos(_dir2),4];
		playSound "HITSFX";
		[] call BRG_fnc_Hit_GUI_Draw3D;
		[_Hit_GUI_Money] execVM "BRG_Functions\GUI_SCRIPTS\REMOVE_Hit_GUI.sqf";
	}];
};
//============================================//
//ADD "Killed" HANDLER
if ((_request == 2) || (_request == 3))  then 
{
	_target addEventHandler ["Killed", { 
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		//EXIT IF AI KILL THEMSELVES
		if (_instigator == _unit) exitWith {};
		private _dir = random(360);
		private _speed = 1;
		private _Reward_Give_Money = round (1000 + random 1500);
		NewMoneyAmount = _Reward_Give_Money;
		private _Killed_GUI_Money = createVehicle ["Land_Money_F", [getPosATL _unit select 0, getPosATL _unit select 1, (getPosATL _unit select 2)], [], 0, "CAN_COLLIDE"];
		_Killed_GUI_Money setPos (_unit modelToWorld [0,0,1]);
		_Killed_GUI_Money setVelocity [_speed * sin(_dir), _speed * cos(_dir),4];
		playSound "HITSFX";
		[] call BRG_fnc_Killed_GUI_Draw3D;
		[_Reward_Give_Money] call INIDB2_fnc_Inidb2RequestSaveMoney;
		hint format ["%1 $", _Reward_Give_Money];
		[_Killed_GUI_Money] execVM "BRG_Functions\GUI_SCRIPTS\REMOVE_Killed_GUI.sqf";
	}];
};
//============================================//