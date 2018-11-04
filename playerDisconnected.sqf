TAG_fnc_loadClientData = {
	_this params ["_loadoutStr", "_positionASL", "_dir"];
	call compile _loadoutStr;
	player setDir _dir;
	player setPosASL _positionASL;
};

if(isServer) then {
	addMissionEventHandler [
		"HandleDisconnect", 
		{
			params ["_body", "_id", "_uid", "_name"];
			
			if(!isNull _body) then {			
				//Init storage var
				if(isNil "TAG_disconnectedLoadouts") then {
					TAG_disconnectedLoadouts = [];
				};
				
				//Save loadout as script for easy broadcast
				private _loadoutStr = [player, "script", false] call BIS_fnc_exportInventory;
				{
					private _index = _loadoutStr find _x;
					if(_index > -1) then {
						private _strArray = toArray _loadoutStr;
						_strArray deleteRange [_index, count _x];
						_loadoutStr = toString _strArray;
					};	
				} forEach ["// Remove existing items","// Add containers","// Add weapons", "// Add items", "// Set identity"];
					
				//Find in storage
				private _uidIndex = TAG_disconnectedLoadouts find _uid;
				if(_uidIndex > -1) then {
					//Found -> update
					private _loadoutIndex = _uidIndex + 1;
					TAG_disconnectedLoadouts set [_loadoutIndex, _loadoutStr];
				} else {
					//Not found -> Add new
					TAG_disconnectedLoadouts pushBack _uid;
					TAG_disconnectedLoadouts pushBack [_loadoutStr, getPosASL _body, getDir _body];
				};
			};
			false
		}
	];

	addMissionEventHandler [
		"PlayerConnected", 
		{
			params ["_id", "_uid", "_name", "_jip", "_owner"];
			if(_jip) then {
				private _clientData = missionNamespace getVariable ["TAG_disconnectedLoadouts", []];
				private _uidIndex = _clientData find _uid;
				if(_uidIndex > -1) then {
					private _loadoutIndex = _uidIndex + 1;
					(_clientData select _loadoutIndex) remoteExec ["TAG_fnc_loadClientData", _owner];
				};
			};
		}
	];
};