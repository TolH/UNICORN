//Starts the Initialization of Server code For @INIDBI2.
	if (isServer) then 
	{
		[] ExecVM "@inidbi2\InitServer\INIDB_Server_UNICORN_Chernarus.sqf";
	};
//REMOVE DEAD PLAYER BODIES WHEN THEY DISCONNECT
    addMissionEventHandler ['HandleDisconnect',{[(_this select 0)] spawn {uiSleep 3; deleteVehicle (_this select 0);};}];