/// @desc Creates a sword instance
/// @arg sword

//Args
var _sword = argument[0];

//Function
mySword = instance_create_layer(x, y, "Instances", oSword);
mySword.type = _sword;
mySword.parent = id;

//Stats
mySword.sprite_index = swStats[_sword, swst.sprite];
mySword.attack = swStats[_sword, swst.attack];
image_speed = swStats[_sword, swst.speed];