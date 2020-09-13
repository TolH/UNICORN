//============================================//
//	TO USE: [] call Tims_fnc_MakeItLoot;
//  _actionRequest = "_MainCrate"
//============================================//
params ["_MainCrate"];
_MainCrate = _this select 0;
//============================================//
	private _EmptyCrate = createVehicle ["Land_PaperBox_01_small_open_brown_IDAP_F", position _MainCrate, [], 0, "CAN_COLLIDE"];
	private _PlayRandomSound = ["LOOTBOXOPENED", "LOOTBOXITEM"] call BIS_fnc_selectRandom;
	_EmptyCrate setPosWorld getPosWorld _MainCrate;
	_EmptyCrate allowDamage false;
	playSound _PlayRandomSound;
	deleteVehicle _MainCrate;
	private _Reward_Give_Money = round (1000 + random 4000);
	[_Reward_Give_Money,0] call INIDB2_fnc_Inidb2RequestSaveMoneyLvlXp;
	hint format ["+%1 $", _Reward_Give_Money];
//============================================//
// 1=PISTOL 2=RIFFLE 3=SMG
private _lootType = 1;
for "_x" from 1 to 1 do 
{
	//PISTOL LOOTS
	if (_lootType == 1) then 
	{
		private _WeaponsList = ["hgun_ACPC2_F","hgun_P07_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F"] call BIS_fnc_selectRandom;
		private _AmmoList = [] + getArray (configFile >> "cfgWeapons" >> _WeaponsList >> "magazines");
		private _dir = random(360);
		private _speed = 1.0;
		private _weaponHold = "WeaponHolderSimulated" createVehicle [0,0,0];
		_weaponHold setPos (_EmptyCrate modelToWorld [0,0,0.5]);
		_weaponHold addWeaponCargoGlobal [_WeaponsList,1];
		_weaponHold addMagazineCargoGlobal [(_AmmoList select 0),1];
		_weaponHold setVelocity [_speed * sin(_dir), _speed * cos(_dir),3];
		_lootType = _lootType + 1;
		uiSleep 0.20;
	};
	//RIFFLE LOOT
	if (_lootType == 2) then 
	{
		private _WeaponsList = ["arifle_Katiba_GL_F"] call BIS_fnc_selectRandom;
		private _AmmoList = [] + getArray (configFile >> "cfgWeapons" >> _WeaponsList >> "magazines");
		private _dir = random(360);
		private _speed = 1.0;
		private _weaponHold = "WeaponHolderSimulated" createVehicle [0,0,0];
		_weaponHold setPos (_EmptyCrate modelToWorld [0,0,0.5]);
		_weaponHold addWeaponCargoGlobal [_WeaponsList,1];
		_weaponHold addMagazineCargoGlobal [(_AmmoList select 0),1];
		_weaponHold setVelocity [_speed * sin(_dir), _speed * cos(_dir),3];
		_lootType = _lootType + 1;
		uiSleep 0.20;
	};
	//SMG LOOT
	if (_lootType == 3) then 
	{
		private _WeaponsList = ["hgun_PDW2000_F","SMG_01_F","SMG_02_F"] call BIS_fnc_selectRandom;
		private _AmmoList = [] + getArray (configFile >> "cfgWeapons" >> _WeaponsList >> "magazines");
		private _dir = random(360);
		private _speed = 1.0;
		private _weaponHold = "WeaponHolderSimulated" createVehicle [0,0,0];
		_weaponHold setPos (_EmptyCrate modelToWorld [0,0,0.5]);
		_weaponHold addWeaponCargoGlobal [_WeaponsList,1];
		_weaponHold addMagazineCargoGlobal [(_AmmoList select 0),1];
		_weaponHold setVelocity [_speed * sin(_dir), _speed * cos(_dir),3];
		uiSleep 0.20;
	};
};
//============================================//