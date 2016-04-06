/**
*   Creates a wave of ai attacking the zcp from 2 locations
*
*
*/
private['_unitsPerGroup','_amountOfGroups','_distanceFromZCP','_useGroundSpawn',
'_useRandomGroupLocations','_spawnAIPos','_capturePosition'
];

switch (ZCP_AI_Type) do {
  case ('DMS'): {
    _waveData = _this select 0;
    _unitsPerGroup = _waveData select 1;
    _amountOfGroups = _waveData select 2;
    _distanceFromZCP = _waveData select 3;

    _useGroundSpawn = _waveData select 4;
    _useRandomGroupLocations = _waveData select 5;

    _capturePosition = _this select 1;

    _spawnAIPos = [_capturePosition, (_distanceFromZCP - 50), (_distanceFromZCP + 50), 1, 0, 9999, 0]; call BIS_fnc_findSafePos;

    _firstRun = true;

    for "_i" from 1 to _amountOfGroups do {
      if(!_firstRun && _useRandomGroupLocations) then {
        _spawnAIPos = [_capturePosition, (_distanceFromZCP - 50), (_distanceFromZCP + 50), 1, 0, 9999, 0]; call BIS_fnc_findSafePos;
      };

      _group = [_spawnAIPos, _unitsPerGroup, "moderate", "random", "bandit"] call DMS_fnc_SpawnAIGroup;
      _group setBehaviour "COMBAT";
      _group setCombatMode "RED";
    };
  };
  case ('FUMS'): {
    diag_log format['[ZCP]: Calling FUMS AI for Wave.'];
    _headlessClients = entities "HeadlessClient_F";

    FuMS_ZCP_Handler = ['Wave',_this];

    {
      diag_log format['[ZCP]: Sending request to client %1', owner _x];
      (owner _x) publicVariableClient "FuMS_ZCP_Handler";
    }count _headlessClients;
  };
  default {
        diag_log format ['[ZCP]: No ai system chosen'];
  };
};
