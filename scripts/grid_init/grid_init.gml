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

if (_cellSize==DIVISION){
	//Tile layers
	var identifier = string(floor(_x)) + "_" + string(floor(_y));
	
	var tback = layer_create(layer_get_depth("Instances")+100, "Tiles_Back_" + identifier);
	var tmback = layer_tilemap_create(tback, _x, _y, tBack, _w/SIZE + 1, _h/SIZE + 1);

	var twalls = layer_create(layer_get_depth("Instances")+50, "Tiles_Walls_" + identifier);
	var tmwalls = layer_tilemap_create(twalls, _x, _y, tWalls, _w/SIZE + 1, _h/SIZE + 1);

	//Fill background layer with grass
	tilemap_clear(tmback, 1);

	//Add to map
	layers_set(floor(_x/AREA), floor(_y/AREA), tback, tmback, twalls, tmwalls);
	
	//Set at start
	if (_x==0 && _y==0){
		global.Tile_Back = layer_get_name(tback);
		global.Tiles_Back = tmback;
		global.Tile_Walls = layer_get_name(twalls);
		global.Tiles_Walls = tmwalls;
	}
}

return [grid, _x, _y];