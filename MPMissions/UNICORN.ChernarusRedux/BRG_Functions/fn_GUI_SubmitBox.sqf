//TO USE: ["text here for title"] call BRG_fnc_GUI_SubmitBox;
params ["_textTitle"];
disableSerialization;

private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
private _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
private _ctrlBackground = _display ctrlCreate ["RscTextMulti", -1, _ctrlGroup];
IDD_EDIT_BOX = 123;
private _ctrlEdit = _display ctrlCreate ["RscEditMulti", IDD_EDIT_BOX, _ctrlGroup];
private _ctrlButton = _display ctrlCreate ["RscShortcutButton", -1, _ctrlGroup];
_ctrlGroup ctrlSetPosition [0.5, 0.5, 0, 0];
_ctrlGroup ctrlCommit 0;
_ctrlBackground ctrlSetPosition [0, 0, 0.5, 0.5];
_ctrlBackground ctrlSetBackgroundColor [0.5, 0.5, 0.5, 0.9];
_ctrlBackground ctrlSetText _textTitle;
_ctrlBackground ctrlEnable false;
_ctrlBackground ctrlCommit 0;
_ctrlEdit ctrlSetPosition [0.01, 0.05, 0.48, 0.34];
_ctrlEdit ctrlSetBackgroundColor [0, 0, 0, 0.5];
_ctrlEdit ctrlCommit 0;
_ctrlButton ctrlSetPosition [0.185, 0.42, 0.13, 0.05];
_ctrlButton ctrlCommit 0;
_ctrlButton ctrlSetText "SUBMIT";
_ctrlButton ctrlAddEventHandler ["ButtonClick", 
{
	params ["_ctrl"];
	_display = ctrlParent _ctrl;
	_text = ctrlText (_display displayCtrl IDD_EDIT_BOX);
	//if (_text == "") then { _text = "EMPTY" };
	//ADD FUNCTION TO INIDBI HERE TO REQUEST FOR SUBMITBOX
	[_text] call INIDB2_fnc_Inidb2RequestSubmitBox;
	_display closeDisplay 1;
}];
ctrlSetFocus _ctrlEdit;
_ctrlGroup ctrlSetPosition [0.25, 0.25, 0.5, 0.5];
_ctrlGroup ctrlCommit 0.1;

playSound "Hint3";