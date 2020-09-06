_Killed_GUI_object = _this select 0;
uiSleep 0.8;
removeMissionEventHandler ["Draw3D", KILLED_GUI_EVENTHANDLER];
deleteVehicle _Killed_GUI_object;