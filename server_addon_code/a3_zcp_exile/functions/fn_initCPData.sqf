private["_nil"];

EAST setFriend[EAST,1];

if(ZCP_dev) then {
	ZCP_MinWaitTime = 10;
	ZCP_MaxWaitTime = 1;
	ZCP_BaseCleanupDelay = 1;
	ZCP_ServerStartWaitTime = 20;
};

ZCP_Version = "ZCP_Exile_2";
ZCP_Data = [];
ZCP_MissionTriggerData = [];
ZCP_MissionCounter = 0;
ZCP_DMS_MagRange = ZCP_DMS_MaximumMagCount - ZCP_DMS_MinimumMagCount;

ZCP_RandomReward = [];

{
	for "_i" from 0 to ((_x select 1) - 1) do {
		_nil = ZCP_RandomReward pushBack (_x select 0);
	};
}count ZCP_RewardWeightForRandomChoice;

{
	_nil = ZCP_Data pushBack [false,0,[-99999,0,0],true];
	_nil = ZCP_MissionTriggerData pushBack [];
	_x set [4, _forEachIndex];
	_x set [3, format['%1%2',(_x select 3),_forEachIndex]];
	if(ZCP_dev) then {
		_x set [12, 120]; // dev time to 60 seconds
	};
} forEach ZCP_CapPoints;

diag_log format['[ZCP]: CPdata: %1', ZCP_CapPoints];
