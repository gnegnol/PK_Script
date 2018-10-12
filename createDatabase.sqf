_clientID = (_this select 0);
_UID = (_this select 1);
_playerName = (_this select 2);

_database = ["new", _UID] call OO_INIDBI;

["write", ["Player Info", "Name", _playerName]] call _database;