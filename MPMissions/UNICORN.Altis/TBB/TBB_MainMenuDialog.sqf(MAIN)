//CREATE THE MAIN TTB_MainMenu DIALOG
	closeDialog 5555;//if already opened so they dont stack
	createDialog "TBB_MainMenu";
//FIND SET CURRENT DISPLAY
	private _ctrl = (findDisplay 5555) displayCtrl 2;
	lbClear _ctrl;
	TBBdialogMain = 0;
//CHECK DATABASE PLAYER MONEY INFO BEFORE PUTTING PRICE UP
	[0] call INIDB2_fnc_Inidb2RequestSaveMoney;
	private _playerMoney = CurrentMoneyAmount;
//BASE BUILDING TEMP OBJECTS LISTS
	private _objectsListMain = [
		["EFM_mobile_dragons_teeth_small_orange", 999]
	];
//ADD DATA (NAME AND PRICE) IN THE GUI
	{
		private _objectName = (_x select 0);
		private _objectPrice = str(_x select 1);
		lbAdd [2, _objectPrice+" "+_objectName];
		if ((_x select 1) > _playerMoney) then { lbSetColor [2, _forEachIndex, [1, 0, 0, 1]]; };
	} forEach _objectsListMain;
	lbSetCurSel [2, 0];
//CYCLE BETWEEN PICTURE ON NEW ITEM SELECTED
	while {TBBdialogMain == 0} do 
	{
		private _index = lbCurSel 2;
		private _objectSelected = lbText [2, _index];
		//FIDDLE AROUND STRING FOR HAVING 2 VALUES WITHIN ONLY ONE STRING FOR _index HAck...
		private _cnt = count _objectSelected;
		private _newObjectStringCut = _objectSelected select [4, _cnt];
		private _objectPrice = _objectSelected select [0, 4];
		private _picture = getText (configfile >> "CfgVehicles" >> _newObjectStringCut >> "editorPreview");
		//SET DATA
		ctrlSetText [4, _picture];
		ctrlSetText [5, _objectPrice+"$"];
		uiSleep 0.20;
	};