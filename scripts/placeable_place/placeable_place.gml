/// @arg grid
/// @arg type
/// @arg x
/// @arg y
/// @arg count_array

//Arguments
var grid = argument[0];
var cell = argument[1];
var X = argument[2];
var Y = argument[3];
var count = argument[4];
					
//Fill surrounding area
var minX = PS[cell, MIN_X];
var maxX = PS[cell, MAX_X];
var minY = PS[cell, MIN_Y];
var maxY = PS[cell, MAX_Y];
					
var w = irandom_range(minX, maxX);
var h = irandom_range(minY, maxY);
					
var startX = X// - irandom(w);
var startY = Y// - irandom(h);
var endX = (startX + w) - 1;
var endY = (startY + h) - 1;
					
//Inside base grid && does not cover any higher priority placement
if (rectangle_in_rectangle(startX, startY, endX, endY, 0, 0, ds_grid_width(grid), ds_grid_height(grid))==1 && ds_grid_get_max(grid, startX, startY, endX, endY)<cell){
	ds_grid_set_region(grid, startX, startY, endX, endY, cell);
					
	//Count
	count[@ cell]++;
	
	return [w, h];
}

return false;