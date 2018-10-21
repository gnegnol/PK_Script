_UID = (_this select 0);
_clientID = (_this select 1);
_database = ["new", _UID] call OO_INIDBI;

_gear = ["read", ["Player Gear", "Gear",[]]] call _database;
loadData = _gear;
_clientID publicVariableClient "loadData";