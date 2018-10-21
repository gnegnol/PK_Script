_clientID = clientOwner;
_UID = getPlayerUID player;
_name = name player;
_gear = getUnitLoadout player;
saveData = [_gear, _UID];
checkForDatabase = [_clientID, _UID, _name];
publicVariableServer "checkForDatabase";
publicVariableServer "saveData";

"loadData" addPublicVariableEventHandler{
	_gear = (_this select 1);
	player setUnitLoadout _gear;
}