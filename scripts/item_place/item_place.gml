/// @arg x
/// @arg y
/// @arg type
/// @arg item

//Args
var _x = argument[0];
var _y = argument[1];
var _type = argument[2];
var _item = argument[3];

//Function
var inst = instance_create_layer(_x, _y, "Instances", oItemPickup);
inst.type = _type;
inst.item = _item;

//Set sprite
var arr = swStats;
if (_type==BOW) arr = bwStats;

inst.sprite_index = arr[_item, swst.sprite];