{
if (isPlayer _x) then {
	_gear = getUnitLoadout player;
	_UID = getPlayerUID player;
	saveData = [_gear, _UID];
	publicVariableServer "saveData";
};
}forEach playableUnits;