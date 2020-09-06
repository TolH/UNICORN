_Hit_GUI_object = _this select 0;
uiSleep 0.8;
removeMissionEventHandler ["Draw3D", HIT_GUI_EVENTHANDLER];
deleteVehicle _Hit_GUI_object;