class TBB_MainMenu
{
	idd = 5555;
	class controls
	{
		class TBB_mainFrame: RscFrame
		{
			idc = 1;

			text = "-=TBB=-"; //--- ToDo: Localize;
			x = 0.237448 * safezoneW + safezoneX;
			y = 0.150029 * safezoneH + safezoneY;
			w = 0.525104 * safezoneW;
			h = 0.699942 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.4};
			sizeEx = 0.03;
		};
		class TBB_objectsList: RscListBox
		{
			idc = 2;

			x = 0.250576 * safezoneW + safezoneX;
			y = 0.178027 * safezoneH + safezoneY;
			w = 0.236297 * safezoneW;
			h = 0.559953 * safezoneH;
			colorBackground[] = {-1,-1,-1,0.5};
		};
		class TBB_buttonBuildObject: RscButton
		{
			idc = 3;
			action = " execVM 'TBB\Build_Btn.sqf' ";

			text = "Build"; //--- ToDo: Localize;
			x = 0.303086 * safezoneW + safezoneX;
			y = 0.751979 * safezoneH + safezoneY;
			w = 0.131276 * safezoneW;
			h = 0.083993 * safezoneH;
			sizeEx = 0.05;
		};
		class TBB_ObjectPicture: RscPicture
		{
			idc = 4;

			x = 0.493436 * safezoneW + safezoneX;
			y = 0.178027 * safezoneH + safezoneY;
			w = 0.262552 * safezoneW;
			h = 0.279977 * safezoneH;
		};
		class TBB_objectPrice: RscText
		{
			idc = 5;

			x = 0.526255 * safezoneW + safezoneX;
			y = 0.388009 * safezoneH + safezoneY;
			w = 0.0525104 * safezoneW;
			h = 0.0699941 * safezoneH;
		};
		class TBB_buttonGet_EFM_list: RscButton
		{
			idc = 6;
			action = " execVM 'TBB\ButtonGetList_EFM.sqf' ";

			text = "@Extended Fortifications Mod"; //--- ToDo: Localize;
			x = 0.493436 * safezoneW + safezoneX;
			y = 0.555995 * safezoneH + safezoneY;
			w = 0.131276 * safezoneW;
			h = 0.083993 * safezoneH;
			sizeEx = 0.035;
		};
		class TBB_buttonGet_NOTUSED_ONE_list: RscButton
		{
			idc = 7;
			action = "	";

			text = "NOT USED #1"; //--- ToDo: Localize;
			x = 0.624712 * safezoneW + safezoneX;
			y = 0.555995 * safezoneH + safezoneY;
			w = 0.131276 * safezoneW;
			h = 0.083993 * safezoneH;
			sizeEx = 0.035;
		};
		class TBB_buttonCloseMenu: RscButton
		{
			idc = 8;
			action = " closeDialog 5555; ";

			text = "Close"; //--- ToDo: Localize;
			x = 0.565244 * safezoneW + safezoneX;
			y = 0.754499 * safezoneH + safezoneY;
			w = 0.131276 * safezoneW;
			h = 0.083993 * safezoneH;
			sizeEx = 0.05;
		};
	};
};
