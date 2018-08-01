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
var marg = 64; //Margin
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

#region Shortcuts
//Restart
if (keyboard_check_pressed(ord("R"))){
	room_restart();
}
#endregion