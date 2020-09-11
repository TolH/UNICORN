//FIND SET CURRENT DISPLAY
	private _ctrl = (findDisplay 5555) displayCtrl 2;
	lbClear _ctrl;
	TBBdialogMain = 1;
//CHECK DATABASE PLAYER MONEY INFO BEFORE PUTTING PRICE UP
	[0] call INIDB2_fnc_Inidb2RequestSaveMoney;
	private _playerMoney = CurrentMoneyAmount;
//BASE BUILDING TEMP OBJECTS LISTS
	private _objectsListEFM = [
		["100 ", "EFM_beam_wood_angular_bearer_01"],
		["100 ", "EFM_beam_wood_h_1_5m"],
		["100 ", "EFM_beam_wood_h_1_5m_railing"],
		["100 ", "EFM_beam_wood_h_1m"],
		["100 ", "EFM_beam_wood_h_1m_railing"],
		["100 ", "EFM_beam_wood_h_2m"],
		["100 ", "EFM_beam_wood_h_2m_railing"],
		["100 ", "EFM_beam_wood_h_3m"],
		["100 ", "EFM_beam_wood_h_3m_railing"],
		["100 ", "EFM_beam_wood_h_4m"],
		["100 ", "EFM_beam_wood_h_4m_railing"],
		["100 ", "EFM_beam_wood_v_0_5m"],
		["100 ", "EFM_beam_wood_v_1_5m"],
		["100 ", "EFM_beam_wood_v_2_75m"],
		["100 ", "EFM_beam_wood_v_2m"],
		["100 ", "EFM_concrete_barrier_new"],
		["100 ", "EFM_concrete_wall_big_pillar_new"],
		["100 ", "EFM_concrete_wall_big_half_new"],
		["100 ", "EFM_concrete_wall_big_new"],
		["100 ", "EFM_concrete_wall_big_new_camo_opfor"],
		["100 ", "EFM_concrete_wall_big_new"],
		["100 ", "EFM_concrete_wall_pillar_new"],
		["100 ", "EFM_concrete_wall_half_new"],
		["100 ", "EFM_concrete_wall_new_camo_blufor"],
		["100 ", "EFM_concrete_wall_new_camo_opfor"],
		["100 ", "EFM_concrete_wall_new"],
		["100 ", "EFM_coverage_camo_net_1_5m_blufor"],
		["100 ", "EFM_coverage_camo_net_1_5m_opfor"],
		["100 ", "EFM_coverage_camo_net_2m_blufor"],
		["100 ", "EFM_coverage_camo_net_2m_opfor"],
		["100 ", "EFM_coverage_concrete_2_7m"],
		["100 ", "EFM_coverage_concrete_2m"],
		["100 ", "EFM_ladder_metal_1_7m"],
		["100 ", "EFM_ladder_metal_2_7m"],
		["100 ", "EFM_ladder_metal_3_7m"],
		["100 ", "EFM_coverage_plywood_2_7m"],
		["100 ", "EFM_coverage_plywood_2_7m_fortified_A"],
		["100 ", "EFM_coverage_plywood_2_7m_fortified_beam"],
		["100 ", "EFM_coverage_plywood_2m_beam"],
		["100 ", "EFM_coverage_plywood_2m"],
		["100 ", "EFM_coverage_plywood_2m_fortified_A"],
		["100 ", "EFM_rack_wood_big_new"],
		["100 ", "EFM_revetment_wall_0_80x0_60x0_90m"],
		["100 ", "EFM_revetment_wall_0_80x0_60x0_90m_soil_double"],
		["100 ", "EFM_revetment_wall_0_80x0_60x0_90m_soil"],
		["100 ", "EFM_revetment_wall_0_80x0_60x0_90m_soil_c_blufor"],
		["100 ", "EFM_revetment_wall_0_80x0_60x0_90m_soil_c_opfor"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m_soil_double"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m_soil_double_c_blufor"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m_soil_double_c_opfor"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m_soil"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m_soil_c_blufor"],
		["100 ", "EFM_revetment_wall_1_60x0_60x0_90m_soil_c_opfor"],
		["100 ", "EFM_stair_wood_1_7m"],
		["100 ", "EFM_stair_wood_2_7m"],
		["100 ", "EFM_stair_wood_3_5m"],
		["100 ", "EFM_support_hole_dirt"],
		["100 ", "EFM_support_hole_soil"],
		["100 ", "EFM_mobile_barrier_A"],
		["100 ", "EFM_mobile_barrier_B"],
		["1000", "EFM_mobile_dragons_teeth_small"],
		["100 ", "EFM_pole_B_01_yellow"],
		["100 ", "EFM_pole_B_02_black"],
		["100 ", "EFM_pole_B_03_black_white"],
		["100 ", "EFM_tetrapod_line"],
		["100 ", "EFM_tetrapod_line_wet"],
		["100 ", "EFM_tetrapod_pile_big"],
		["100 ", "EFM_tetrapod_pile_big_wet"],
		["100 ", "EFM_tetrapod_single"],
		["100 ", "EFM_tetrapod_single_wet"],
		["100 ", "EFM_ground_surface_2x2m_soil"],
		["100 ", "EFM_ground_surface_4x4m_soil"],
		["100 ", "EFM_ground_surface_8x4m_soil"],
		["100 ", "EFM_ground_surface_2x2m_dirt"],
		["100 ", "EFM_ground_surface_4x4m_dirt"],
		["100 ", "EFM_ground_surface_8x4m_dirt"],
		["100 ", "EFM_wood_wall_2m_half_single"],
		["100 ", "EFM_wood_wall_2m_half_beam_single_c_blufor"],
		["100 ", "EFM_wood_wall_2m_half_beam_single_c_opfor"],
		["100 ", "EFM_wood_wall_2m_half_single_filled"],
		["100 ", "EFM_wood_wall_2m_half_beam_single_filled_c_blufor"],
		["100 ", "EFM_wood_wall_2m_half_beam_single_filled_c_opfor"],
		["100 ", "EFM_wood_wall_2m_single"],
		["100 ", "EFM_wood_wall_2m_single_filled"],
		["100 ", "EFM_wood_wall_2m_half_beam_single"],
		["100 ", "EFM_wood_wall_2m_half_beam_single_c_blufor"],
		["100 ", "EFM_wood_wall_2m_half_beam_single_filled"],
		["100 ", "EFM_wood_wall_2m_support"]
	];
//ADD DATA (NAME AND PRICE) IN THE GUI
	{
		private _objectPrice = (_x select 0);
		private _objectName = (_x select 1);
		private _objectPriceParse = parseNumber _objectPrice;
		lbAdd [2, _objectPrice+" "+_objectName];
		if (_objectPriceParse > _playerMoney) then { lbSetColor [2, _forEachIndex, [1, 0, 0, 1]]; };
	} forEach _objectsListEFM;
	lbSetCurSel [2, 0];
//CYCLE BETWEEN PICTURE ON NEW ITEM SELECTED
	while {TBBdialogMain == 1} do 
	{
		private _index = lbCurSel 2;
		private _objectSelected = lbText [2, _index];
		//FIDDLE AROUND STRING FOR HAVING 2 VALUES WITHIN ONLY ONE STRING FOR _index HAck...
		private _cnt = count _objectSelected;
		private _newObjectStringCut = _objectSelected select [5, _cnt];
		private _objectPrice = _objectSelected select [0, 5];
		private _picture = getText (configfile >> "CfgVehicles" >> _newObjectStringCut >> "editorPreview");
		//SET DATA
		ctrlSetText [4, _picture];
		ctrlSetText [5, _objectPrice+"$"];
		uiSleep 0.20;
	};