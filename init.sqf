_clientID = clientOwner;
_UID = getPlayerUID player;
_name = name player;
checkForDatabase = [_clientID, _UID, _name];
publicVariableServer "checkForDatabase";

player addAction ["save data",{
	_gear = getUnitLoadout player;
	_UID = getPlayerUID player;
	saveData = [_gear, _UID];
	publicVariableServer "saveData";
}];