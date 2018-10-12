

{
    private ["_unit"];
    _unit = _x;

    // Only run where the unit is local, it isn't a player and doesn't have a flashlight
    if (local _unit && !isplayer _unit && !("acc_flashlight" in primaryWeaponItems _unit)) then {

    // Remove laser if equipped
    if ("acc_pointer_IR" in primaryWeaponItems _unit) then {_x removePrimaryWeaponItem "acc_pointer_IR"};
    _unit addPrimaryWeaponItem "acc_flashlight";    // Add flashlight

        // Removes NVGs from unit
        {
            if (_x in assigneditems _unit) exitWith {_unit unlinkItem _x};
        } forEach ["NVGoggles_OPFOR","NVGoggles_INDEP","NVGoggles"];
    };

    // Forces flashlights on
     _unit enablegunlights "forceOn";
} forEach allUnits;


//[] execVM "QS_icons.sqf"

[] execVM "module_chatIntercept\init.sqf";