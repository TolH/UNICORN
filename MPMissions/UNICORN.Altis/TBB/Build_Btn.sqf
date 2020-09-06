//FIND SET RIGHT DIALOG
_ctrl = (findDisplay 5555) displayCtrl 2;
	//CHECK PLAYER SELECTED ITEM
	_index = lbCurSel 2;
	_objectSelected = lbText [2, _index];
	//DO SOME STRING MAGIC TO BE ABLE TO GET PRICE INFO AND OBJECT NAME WITHIN THE SAME STRING
	_cnt = count _objectSelected;
	_newObjectStringCut = _objectSelected select [4, _cnt];
	_objectPrice = _objectSelected select [0, 4];
	_objectPriceToString = _objectPrice call BIS_fnc_parseNumber;
	//CHECK IF PLAYER HAS ENOUGH MONEY
	_playerHasMoney = CurrentMoneyAmount - _objectPriceToString;
	//CREATE PLAYER SELECTED OBJECT
	if (_playerHasMoney >= 0) then 
	{
		//PUT PLAYER IN BUILD MODE
		PLAYERISBUILDING = 1;
		_ObjAtPlayerPos = getPosATL player;
		_buildObject = createVehicle [_newObjectStringCut, [_ObjAtPlayerPos select 0, (_ObjAtPlayerPos select 1)+3, (_ObjAtPlayerPos select 2)+1], [], 0, "CAN_COLLIDE"];
		_buildObject attachto [player, [0,3,1]];
		//CLOSE DIALOG
		closeDialog 5555;
		hint "PRESS (SPACE) TO PLACE THAT OBJECT.";
		//WAIT UNTIL PLAYER PLACED THE OBJECT BY USING "SPACE" KEY
		waitUntil { uiSleep 0.1; PLAYERISBUILDING == 0; };
		playSound "BUILDSFX";
		[-_objectPriceToString] call INIDB2_fnc_Inidb2RequestSaveMoney;
		detach _buildObject;
		//SAVE OBJECTS TO DATABASE
		[_buildObject] call INIDB2_fnc_Inidb2RequestSavePlayerBase;
	} else
	{
		hint "Not enough $$$ \nSelect something else.";
	};

