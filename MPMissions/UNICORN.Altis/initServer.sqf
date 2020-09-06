//Starts the Initialization of Server code For TIMS.
	if (isServer) then 
	{
		[] ExecVM "@inidbi2\InitServer\INIDB_Server_0908_BRG_Altis.sqf";
		setTimeMultiplier 40;
	};
//REMOVE DEAD PLAYER BODIES WHEN THEY DISCONNECT
    addMissionEventHandler ['HandleDisconnect',{[(_this select 0)] spawn {uiSleep 3; deleteVehicle (_this select 0);};}];