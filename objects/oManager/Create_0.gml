/// @description 
randomize();

#region Proc Gen
//Base
var grid = grid_init(0, 0, AREA, AREA, DIVISION);
grid_populate(grid);

debugGrid = grid[pr.grid];
#endregion

#region Camera
cameraEnabled = false;
cameraX = 0;
cameraY = 0;

if (cameraEnabled){
	view_enabled = true;
	view_visible[0] = true;

	var width = 64, height = 64, scale = 10;

	var cam = camera_create_view(0, 0, width, height, 0, -1, -1, -1, width/2, height/2);
	view_set_camera(0, cam);

	window_set_size(width*scale, height*scale);
	surface_resize(application_surface, width*scale, height*scale);

	window_set_position(display_get_width()/2-(width*scale)/2, display_get_height()/2-(height*scale)/2);
	display_set_gui_size(width, height);
}
#endregion