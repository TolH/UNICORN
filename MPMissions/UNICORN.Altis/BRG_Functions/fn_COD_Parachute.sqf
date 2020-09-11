//============================================//
//	TO USE: [] call BRG_fnc_ActivateParachute;
//============================================//
PARACHUTE_IN_USE = 0;
//SPAWN PARACHUTE TO PLAYER
if (vehicle player == player) then 
{
	if ((vehicle player IsEqualto player) && (alive player)) then
	{
		player switchCamera "EXTERNAL";
		addCamShake [6, 3, 15];
		playSound "PARACHUTESFX";
		private _chute = createVehicle ["Steerable_Parachute_F", position Player, [], 0, "FLY"];
		_chute setPos [(position player select 0), (position player select 1), (position player select 2)];
		_chute setDir direction player;
		player moveIndriver _chute;
		//SET PARACHUTE VARS TO ENABLED 
		PARACHUTE_IN_USE = 1;
	};
};
//DETACH FROM PARACHUTE IF ALREADY USING IT
if ((typeOf vehicle player == "Steerable_Parachute_F") && (PARACHUTE_IN_USE == 0)) then 
{
	playSound "PARACHUTEOFF";
	deletevehicle (vehicle player);
};
//============================================//