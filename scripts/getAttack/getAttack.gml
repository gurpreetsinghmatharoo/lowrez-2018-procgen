/// @desc Returns the attacking instance
/// @arg x
/// @arg y

//Args
var _x = argument[0];
var _y = argument[1];

//Sword
var inst = instance_place(_x, _y, oSword);

if (inst) return inst;

//Arrow
inst = instance_place(_x, _y, oArrow);

if (inst) return inst;

//Nothing
return noone;