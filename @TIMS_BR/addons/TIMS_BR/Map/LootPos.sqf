//============================================////============================================//

if (isServer) then 
{
	//============================================//
	//ALL LOOTBOX POSITION
	private _objects = 
	[
		//MILITARY BASE "CLOSED" LOOTBOX POSITION
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9705.45,3967.75,39.097],[[-0.00730469,-0.999973,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9796.36,3864.79,39.097],[[-0.00730469,-0.999973,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9739.44,3854.29,39.097],[[-0.00730469,-0.999973,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9789.53,3913.63,39.097],[[-0.999932,0.0116513,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9664.47,3481.01,36.437],[[-0.849202,0.528069,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9650.69,3307.69,44.457],[[-0.00730469,-0.999973,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9338.76,3875.62,3.88697],[[0.955693,0.294364,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9280.72,3729.77,3.75025],[[0.999698,-0.024564,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[9455.35,4157.56,34.4864],[[0.71091,0.703283,0],[0,0,1]],[true,false]],
		["Land_PaperBox_01_small_closed_brown_IDAP_F",[10062.8,3991.63,27.992],[[-0.999851,-0.00418183,0.0167773],[0.0167973,-0.00479591,0.999847]],[true,false]]
	];
	//============================================//
	//SPAWN OBJECTS
	{
		//MILITARY BASE "CLOSED" LOOTBOX
		private _object = (_x select 0) createVehicle [0,0,0];
		_object enableSimulationGlobal ((_x select 3) select 0);
		_object allowDamage ((_x select 3) select 1);
		_object setPosWorld (_x select 1);
		_object setVectorDirAndUp (_x select 2);
		//ADD THE ACTUAL LOOT FUNCTION TO THE LOOTBOX
		[
			_object,
			"Loot",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
			"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
			"_this distance _target < 3",
			"_caller distance _target < 3",
			{},
			{},
			{ _this call BRG_fnc_MakeItLoot; },
			{},
			[],
			1,
			0,
			true,
			false
		] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];
	} forEach _objects;
};
//============================================////============================================//
//LOOT TEST
/*_spawnChanceWeapons = 13;
_spawnChanceItems = 7;
_magazineArry = [1, 2, 3, 4];
_houseMarker = getPos LOOT_TRIGGER;
_rifleArray = ["arifle_TRG21_F"];
_pistolArray = ["hgun_ACPC2_F", "hgun_Pistol_heavy_01_F", "hgun_P07_F", "hgun_Pistol_heavy_02_F"];
_backpackArray = ["B_AssaultPack_khk", "B_Kitbag_mcamo", "B_Carryall_cbr"];
_vestArray = ["V_TacVestIR_blk"];
_helmetArray = ["H_HelmetB_light"];
_attachmentArray = ["muzzle_snds_M", "muzzle_snds_B", "muzzle_snds_93mmg", "optic_Holosight", "optic_MRCO", "optic_LRPS"];
_triggerSize = triggerArea LOOT_TRIGGER;
_sizeX = _triggerSize select 0;
_sizeY = _triggerSize select 1;

_areaSize = _sizeX;
if (_sizeY > _sizeX) then
{
	_areaSize = _sizeY;
};

_houses = _houseMarker nearObjects ["house", _areaSize];
{
	_buildingPos = [_x] call BIS_fnc_buildingPositions;
	{
		if (_spawnChanceWeapons > random 100) then //weapons
			{
				_rifle = _rifleArray call BIS_fnc_selectRandom;
				_magazineCount = _magazineArry call BIS_fnc_selectRandom;
				_holder = "WeaponHolderSimulated" createVehicle [0,0,0];
				_holder setPos _x;
				_holder addWeaponCargoGlobal [_rifle, 1];
				_wepMagazines = getArray (configFile >> "CfgWeapons" >> _rifle >> "magazines");
				_magazines = _wepMagazines select 0;
				_holder addMagazineCargoGlobal [_magazines, _magazineCount];
			};
	} forEach _buildingPos;
	{
		if (_spawnChanceWeapons > random 100) then //weapons
			{
				_pistol = _pistolArray call BIS_fnc_selectRandom;
				_magazineCount = _magazineArry call BIS_fnc_selectRandom;
				_holder = "WeaponHolderSimulated" createVehicle [0,0,0];
				_holder setPos _x;
				_holder addWeaponCargoGlobal [_pistol, 1];
				_wepMagazines = getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines");
				_magazines = _wepMagazines select 0;
				_holder addMagazineCargoGlobal [_magazines, _magazineCount];
			};
	} forEach _buildingPos;
	{
		if (_spawnChanceItems > random 100) then //backpacks
		{
			_backpack = _backpackArray call BIS_fnc_selectRandom;
			_holder = "WeaponHolderSimulated" createVehicle [0,0,0];
			_holder setPos _x;
			_holder addbackpackCargoGlobal [_backpack, 1];
		};
	} forEach _buildingPos;
	{
		if (_spawnChanceItems > random 100) then //vests
		{
			_vest = _vestArray call BIS_fnc_selectRandom;
			_holder = "WeaponHolderSimulated" createVehicle [0,0,0];
			_holder setPos _x;
			_holder additemCargoGlobal [_vest, 1];
		};
	} forEach _buildingPos;
	{
		if (_spawnChanceItems > random 100) then //helmets
		{
			_helmet = _helmetArray call BIS_fnc_selectRandom;
			_holder = "WeaponHolderSimulated" createVehicle [0,0,0];
			_holder setPos _x;
			_holder additemCargoGlobal [_helmet, 1];
		};
	} forEach _buildingPos;
	{
		if (_spawnChanceItems > random 100) then //attachments
		{
			_attachment = _attachmentArray call BIS_fnc_selectRandom;
			_holder = "WeaponHolderSimulated" createVehicle [0,0,0];
			_holder setPos _x;
			_holder additemCargoGlobal [_attachment, 1];
		};
	} forEach _buildingPos;
} forEach _houses;
*/