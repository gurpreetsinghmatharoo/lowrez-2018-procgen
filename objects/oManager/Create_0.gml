/// @description 
randomize();
application_surface_draw_enable(false);
show_debug_overlay(1);

#region Vars
//Zoom
zoomEnabled = 1;
zoomSpeed = 64;
#endregion

#region Proc Gen
//Base
var grid = grid_init(0, 0, AREA, AREA, DIVISION);
grid_populate(grid);

//Debug
//debugGrids = ds_list_create();
//ds_list_add(debugGrids, grid);

areaX = 0;
areaY = 0;

//Create player
var _x = irandom(AREA/DIVISION - 1) * DIVISION + DIVISION/2;
var _y = irandom(AREA/DIVISION - 1) * DIVISION + DIVISION/2;
instance_create_layer(_x, _y, "Instances", oPlayer);
#endregion

#region Camera
cameraEnabled = 1;

if (cameraEnabled){
	view_enabled = true;
	view_visible[0] = true;
	
	var width = CAM.W, height = CAM.H, scale = CAM.SCALE;

	var cam = camera_create_view(0, 0, width, height, 0, -1, -1, -1, width/2, height/2);
	view_set_camera(0, cam);

	window_set_size(width*scale, height*scale);
	surface_resize(application_surface, width*scale, height*scale);

	window_set_position(display_get_width()/2-(width*scale)/2, display_get_height()/2-(height*scale)/2);
	display_set_gui_size(width, height);
}
#endregion

#region Tiles
global.Tiles_Walls = layer_tilemap_get_id("Tiles_Walls");
#endregion