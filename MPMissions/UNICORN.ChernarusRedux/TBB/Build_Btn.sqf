//FIND SET RIGHT DIALOG
private _ctrl = (findDisplay 5555) displayCtrl 2;
	//CHECK PLAYER SELECTED ITEM
	private _index = lbCurSel 2;
	private _objectSelected = lbText [2, _index];
	//DO SOME STRING MAGIC TO BE ABLE TO GET PRICE INFO AND OBJECT NAME WITHIN THE SAME STRING
	private _cnt = count _objectSelected;
	private _newObjectStringCut = _objectSelected select [5, _cnt];
	private _objectPrice = _objectSelected select [0, 5];
	private _objectPriceToString = _objectPrice call BIS_fnc_parseNumber;
	//CHECK IF PLAYER HAS ENOUGH MONEY
	private _playerHasMoney = CurrentMoneyAmount - _objectPriceToString;
	//ADD CHECK IF BASE STARTER ITEM ARE AROUND BEFORE BUILDING OBJECT.
	private _hasBaseStarter = nearestObjects [player, ["EFM_mobile_dragons_teeth_small_orange"], 25];//RANGE HERE TO BE MODIFIED DEPENDING ON PLAYER LEVEL
	//CREATE PLAYER SELECTED OBJECT
	if ((_playerHasMoney >= 0) && (count _hasBaseStarter == 1)) then 
	{
		//PUT PLAYER IN BUILD MODE
		PLAYERISBUILDING = 1;
		private _ObjAtPlayerPos = getPosATL player;
		private _buildObject = createVehicle [_newObjectStringCut, [_ObjAtPlayerPos select 0, (_ObjAtPlayerPos select 1)+3, (_ObjAtPlayerPos select 2)+1], [], 0, "CAN_COLLIDE"];
		_buildObject attachto [player, [0,3,1]];
		closeDialog 5555;
		hint format ["PRESS (SPACE) TO PLACE THAT OBJECT.\nUSE ARROW KEYS TO MOVE OBJECT.\nESC TO CANCEL."];
		//LOOP HERE TO BE ABLE TO TRACK KEYPRESS AND MOVING OBJECT WITH ATTACH POS
		//_ObjAtPlayerPos setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
		//private _CurrentRotatedirVector = vectorDir _buildObject;
		private _defaultAttachPosUPandDOWN = 1;
		private _CurrentRotatedirVector = getDir _buildObject;
		while {PLAYERISBUILDING == 1} do 
		{
			//UP
			if (PLAYEROBJECTMOVE == 1) then 
			{
				_buildObject attachto [player, [0,3,_defaultAttachPosUPandDOWN +0.10]];
				_defaultAttachPosUPandDOWN = _defaultAttachPosUPandDOWN +0.10;
				PLAYEROBJECTMOVE = 0;
			};
			//DOWN
			if (PLAYEROBJECTMOVE == 2) then 
			{
				_buildObject attachto [player, [0,3,_defaultAttachPosUPandDOWN -0.10]];
				_defaultAttachPosUPandDOWN = _defaultAttachPosUPandDOWN -0.10;
				PLAYEROBJECTMOVE = 0;
			};
			//ROTATE LEFT
			if (PLAYEROBJECTMOVE == 3) then 
			{
				_buildObject setDir _CurrentRotatedirVector -10;
				_CurrentRotatedirVector = _CurrentRotatedirVector -10;
				PLAYEROBJECTMOVE = 0;
			};
			//ROTATE RIGHT
			if (PLAYEROBJECTMOVE == 4) then 
			{
				_buildObject setDir _CurrentRotatedirVector +10;
				_CurrentRotatedirVector = _CurrentRotatedirVector +10;
				PLAYEROBJECTMOVE = 0;
			};
			//CANCEL OBJECT
			if (PLAYEROBJECTCANCEL == 1) then 
			{
				deleteVehicle _buildObject;
				PLAYERISBUILDING = 0;
			};
			uiSleep 0.20;
		};
		//WAIT UNTIL PLAYER PLACED THE OBJECT BY USING "SPACE" KEY
		waitUntil { uiSleep 0.20; PLAYERISBUILDING == 0; };
		//IF PLAYER CANCELLED THE OBJECT
		if (PLAYEROBJECTCANCEL == 1) then 
		{
			hint "Cancelled current object";
			PLAYEROBJECTCANCEL = 0;
			TBBdialogMain = 0;
		} else
		{
			[-_objectPriceToString,0] call INIDB2_fnc_Inidb2RequestSaveMoneyLvlXp;
			detach _buildObject;
			//SAVE OBJECTS TO DATABASE
			[_buildObject] call INIDB2_fnc_Inidb2RequestSavePlayerBase;
			TBBdialogMain = 0;
		};
	} else
	{
		if (count _hasBaseStarter == 1) then
		{
			hint "Not enough $$$\nSelect something else.";
		} else
		{
			hint "Out of range.\nOr no base starter object around";
			closeDialog 5555;
		};
	};

