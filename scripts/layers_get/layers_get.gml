/// @arg areaX
/// @arg areaY

//Args
var _x = argument[0];
var _y = argument[1];

//Function
var key = string(floor(_x)) + "|" + string(floor(_y));

log("Loaded layers from " + key);

return global.layers[? key];