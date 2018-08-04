/// @description 
randomize();
//application_surface_draw_enable(false);
//show_debug_overlay(1);

#region Main
//Depth Manager
instance_create_layer(0, 0, "Instances", oDepth);

//Create layers DS Map
global.layers = ds_map_create();

//Font
//ftMain = font_add_sprite(sFont, ord("A"), true, 1);
draw_set_font(ftMain);
#endregion

#region HUD
//Visibility
hideHUD = false;
y1 = 0;
y2 = CAM.H;
global.showTime = 0;
#endregion

#region Vars
//Zoom
zoomEnabled = 1;
zoomSpeed = 64;
#endregion

#region Start the game
//Create player
var _x = irandom(AREA/DIVISION - 1) * DIVISION + DIVISION/2;
var _y = irandom(AREA/DIVISION - 1) * DIVISION + DIVISION/2;
instance_create_layer(_x, _y, "Instances", oPlayer);

//Base area
var grid = grid_init(0, 0, AREA, AREA, DIVISION);
grid_populate(grid);

//Area coordinate variables
areaX = 0;
areaY = 0;
areaPrevX = areaX;
areaPrevY = areaY;

//Place sword
var _x, _y, _dir, marg = 16;
do{
	_dir = random(360);
	_x = oPlayer.x + lengthdir_x(CAM.W/4, _dir);
	_y = oPlayer.y + lengthdir_y(CAM.W/4, _dir);
}
until(!collision_rectangle(_x-marg, _y-marg, _x+marg, _y+marg, oPlaceable, 0, 0))

item_place(_x, _y, SWORD, sword.basic);

//Test enemy
instance_create_layer(_x, _y-32, "Instances", oEnemy);
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
	surface_resize(application_surface, width, height);

	window_set_position(display_get_width()/2-(width*scale)/2, display_get_height()/2-(height*scale)/2);
	display_set_gui_size(width, height);
}
#endregion