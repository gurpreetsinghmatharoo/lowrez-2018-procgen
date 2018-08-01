/// @arg room_x
/// @arg room_y
/// @arg area_w
/// @arg area_h
/// @arg cell_size

//Args
var _x = argument[0];
var _y = argument[1];
var _w = argument[2];
var _h = argument[3];
var _cellSize = argument[4];

//Function
var gW = _w div _cellSize;
var gH = _h div _cellSize;
var grid = ds_grid_create(gW, gH);
ds_grid_clear(grid, A.EMPTY);

//Generated instance
instance_create_layer(_x, _y, "Manager", oGenerated);

return [grid, _x, _y];