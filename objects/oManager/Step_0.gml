/// @description 
#region Proc Gen
//Player
var plrX = oPlayer.x;
var plrY = oPlayer.y;

//Area Coordinates
areaX = floor(plrX / AREA);
areaY = floor(plrY / AREA);
areaXReal = areaX*AREA;
areaYReal = areaY*AREA;

//New area generation
var marg = 32; //Margin
var cX = oPlayer.x - CAM.W/2, cY = oPlayer.y - CAM.H/2;

//If, including margin, the camera intersects the boundary, generate new area
if (rectangle_in_rectangle(cX-marg, cY-marg, cX+CAM.W+marg, cY+CAM.H+marg,
	areaXReal, areaYReal, areaXReal+AREA, areaYReal+AREA) == 2){
	//Check for each of the surrounding areas
	for(var X = -1; X <= 1; X ++){
		for(var Y = -1; Y <= 1; Y ++){
			//Make sure it's not the current area
			if !(X==0 && Y==0){
				//Area coordinates
				var _areaX = areaX + X;
				var _areaY = areaY + Y;
				var _areaXReal = _areaX*AREA;
				var _areaYReal = _areaY*AREA;
				
				//Check for rectangle overlap
				if (rectangle_in_rectangle(cX-marg, cY-marg, cX+CAM.W+marg, cY+CAM.H+marg,
					_areaXReal, _areaYReal, _areaXReal+AREA, _areaYReal+AREA) == 2
					&& !area_generated(_areaXReal, _areaYReal)){
					//Generate
					var grid = grid_init(_areaXReal, _areaYReal, AREA, AREA, DIVISION);
					grid_populate(grid);

					//Debug
					//ds_list_add(debugGrids, grid);
				}
			}
		}
	}
}


#endregion

#region Changing area
if (areaX != areaPrevX || areaY != areaPrevY){
	var arr = layers_get(areaX, areaY);
	global.Tile_Back = layer_get_name(arr[0]);
	global.Tiles_Back = arr[1];
	global.Tile_Walls = layer_get_name(arr[2]);
	global.Tiles_Walls = arr[3];
}
#endregion

#region Levels
//Leveling up
with (oPlayer){
	global.reqXP = global.xpBase + ((level-1)*global.xpAdd);
	
	if (xp >= global.reqXP){
		//Decrease xp
		xp -= global.reqXP;
		
		//Increase level
		level++;
	}
}
#endregion

#region HUD
//Lerp ys
var dist = CAM.H/2;
var spd = 0.1 * (1 + !hideHUD);
y1 = lerp(y1, -dist*hideHUD, 0.05 * (1 + !hideHUD*4));
y2 = lerp(y2, CAM.H+dist*hideHUD, 0.05 * (1 + !hideHUD*4));

//Hide
if (global.showTime || oPlayer.stopTime > 15){
	hideHUD = false;
}
else if (oPlayer.moveTime > 15){
	hideHUD = true;
}

//Show time cooldown
global.showTime -= global.showTime > 0;
#endregion

#region Shortcuts
//Restart
if (keyboard_check_pressed(ord("R"))){
	room_restart();
}

//HQ
if (keyboard_check_pressed(ord("H"))){
	if (surface_get_width(application_surface)==CAM.W){
		surface_resize(application_surface, CAM.W*CAM.SCALE, CAM.H*CAM.SCALE);
	}
	else{
		surface_resize(application_surface, CAM.W, CAM.H);
	}
}
#endregion