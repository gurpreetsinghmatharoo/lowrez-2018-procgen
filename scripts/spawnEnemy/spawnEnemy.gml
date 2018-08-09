/// @arg x
/// @arg y
/// @arg type
/// @arg playerLevel
/// @arg activity

//Args
var _x = argument[0];
var _y = argument[1];
var _type = argument[2];
var _playerLevel = argument[3];
var _act = argument[4];

//Select level
var maxLevel = _playerLevel;
var minLevel = max(1, _playerLevel - 2);
var level = irandom_range(minLevel, maxLevel);

//Spawn
var inst = instance_create_layer(_x, _y, "Instances", oEnemy);
inst.level = level;
inst.type = _type;
inst.sprites = enmSt[_type, enmst.sprites];
inst.attack = enmSt[_type, enmst.attack];
inst.defense = enmSt[_type, enmst.defense];
inst.activity = _act;

return inst;