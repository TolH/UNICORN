//============================================//
//	TO USE: [] call BRG_fnc_Hit_GUI_Draw3D;
//============================================//
HIT_GUI_EVENTHANDLER = addMissionEventHandler ["Draw3D", {
	private _drone = getConnectedUAV player;
	if (!(isNull _drone) && {((UAVControl _drone) select 0) isEqualTo player} && {!(((UAVControl _drone) select 1) isEqualTo "")}) exitWith {};
	if (!isNull cameraOn) then
	{
		{
			if (!isNull _x) then
			{
				//WORLD_RANDOM_LOOTBOX
				if (typeOf _x == "Land_Matches_F") then 
				{
					private _font = "RobotoCondensedBold";
					private _distance = cameraOn distance _x;
					private _alpha = (1-(_distance/1500));
					private _clr = [1,0,0,_alpha];
					private _pos = _x modelToWorldVisual (_x selectionPosition "head");
					_pos set[2, (_pos select 2)];
					drawIcon3D["", _clr, _pos, 0.60, 0.60, 0, '-' + str NewHitAmount, 2, 0.042, _font];
				};
			};
		}forEach ((cameraOn nearEntities[['Land_Matches_F','LandVehicle','Ship','Air'],1500]) - [cameraOn,vehicle cameraOn]);
	};
}];