//============================================//
//	TO USE: [] call BRG_fnc_Killed_GUI_Draw3D;
//============================================//
removeMissionEventHandler ["Draw3D", HIT_GUI_EVENTHANDLER];
KILLED_GUI_EVENTHANDLER = addMissionEventHandler ["Draw3D", {
	private _drone = getConnectedUAV player;
	if (!(isNull _drone) && {((UAVControl _drone) select 0) isEqualTo player} && {!(((UAVControl _drone) select 1) isEqualTo "")}) exitWith {};
	if (!isNull cameraOn) then
	{
		{
			if (!isNull _x) then
			{
				//WORLD_RANDOM_LOOTBOX
				if (typeOf _x == "Land_Money_F") then 
				{
					private _font = "RobotoCondensedBold"; //RobotoCondensedBold, LucidaConsoleB, EtelkaMonospaceProBold, PuristaSemiBold, PuristaBold
					private _distance = cameraOn distance _x;
					private _alpha = (1-(_distance/1500));
					private _clr = [0.75,0.30,0.10,_alpha];
					private _pos = _x modelToWorldVisual (_x selectionPosition "head");
					_pos set[2, (_pos select 2) + 1];
					drawIcon3D["", _clr, _pos, 0.60, 0.60, 0, '+' + str NewMoneyAmount + ' $$', 2, 0.042, _font];
				};
			};
		}forEach ((cameraOn nearEntities[['Land_Money_F','LandVehicle','Ship','Air'],1500]) - [cameraOn,vehicle cameraOn]);
	};
}];