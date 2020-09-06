class CfgPatches 
{
	class TIMS_BR 
	{
		units[] = {};
		weapons[] = {}; 
		requiredAddons[] = {};	
		author[]= {"TOLH"}; 		
	};
};

class CfgFunctions
{
	class TIMS_BR_launch
	{
		class TIMS_BR_Initialization
		{
			class Init
			{
				file = "TIMS_BR\fn_init.sqf";
				preInit = 1;
			};
		};
	};
};