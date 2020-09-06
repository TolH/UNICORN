//============================================//
//  EXEMPLE TAKEN FROM EXIL MOD
//	TO USE: [3200] call BRG_fnc_StartCustomNameplate;
//	 params ["_espRenderRange"];
//============================================//
params ["_espRenderRange"];
private _drone = getConnectedUAV player;
if (!(isNull _drone) && {((UAVControl _drone) select 0) isEqualTo player} && {!(((UAVControl _drone) select 1) isEqualTo "")}) exitWith {};
if (!isNull cameraOn) then
{
	{
		if (!isNull _x) then
		{
			//PLAYERS NAMETAG
			/*if (isPlayer _x) then
			{
				if !(isObjectHidden _x) then 
				{
					private _font1 = "RobotoCondensedBold";
					private _distance1 = cameraOn distance _x;
					private _alpha1 = (1-(_distance1/_espRenderRange));
					private _clr1 = [0,0.9,0,_alpha1];
					private _crew1 = crew (vehicle _x);
					private _name1 = '';
					{
						if(_forEachIndex == 0) then
						{
							_name1 = _name1 + format['%1 [%2m]',name _x, round(player distance _x)];
						}
						else
						{
							if (alive _x) then 
							{
								_name1 = _name1 + format['%1 [%2m]', name _x, round(player distance _x)];
							};
						};
					}forEach _crew1;
					private _pos1 = _x modelToWorldVisual (_x selectionPosition "head");
					_pos1 set[2, (_pos1 select 2) + 1];
					drawIcon3D["a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoPut_ca.paa", _clr1, _pos1, 0.70, 0.70, 0, _name1, 2, 0.032, _font1];
				};
			};*/
			//WORLD_RANDOM_LOOTBOX
			if (!(isTouchingGround player) && ((position player select 2) >= 10) && (typeOf _x == "Land_PaperBox_01_small_closed_brown_IDAP_F")) then 
			{
				private _font3 = "RobotoCondensedBold";
				private _distance3 = cameraOn distance _x;
				private _alpha3 = (1-(_distance3/1000));
				private _clr3 = [0.1,0,0.9,_alpha3];
				private _name3 = '';
				private _pos3 = _x modelToWorldVisual (_x selectionPosition "head");
				_pos3 set[2, (_pos3 select 2) + 0.50];
				drawIcon3D["a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMisc_ca.paa", _clr3, _pos3, 0.60, 0.60, 0, _name3, 2, 0.032, _font3];
			};
		};
	}forEach ((cameraOn nearEntities[['Land_PaperBox_01_small_closed_brown_IDAP_F','LandVehicle','Ship','Air'],_espRenderRange]) - [cameraOn,vehicle cameraOn]);
};