/// @desc Creates a sword instance
/// @arg sword

//Args
var _sword = argument[0];

//Function
mySword = instance_create_layer(x, y, "Instances", oSword);
mySword.type = _sword;
mySword.parent = id;
mySword.sprite_index = swSpr[_sword];
mySword.attack = swStats[_sword, swst.attack];

//Animation speed
image_speed = swStats[_sword, swst.speed];