/// @arg areaX
/// @arg areaY
/// @arg Tile_Back
/// @arg Tile_Walls
/// @arg Tiles_Back
/// @arg Tiles_Walls

//Args
var _x = argument[0];
var _y = argument[1];
var _back = argument[2];
var _mback = argument[3];
var _walls = argument[4];
var _mwalls = argument[5];

//Function
var key = string(floor(_x)) + "|" + string(floor(_y));
global.layers[? key] = [_back, _mback, _walls, _mwalls];

log("Saved layers as " + key);