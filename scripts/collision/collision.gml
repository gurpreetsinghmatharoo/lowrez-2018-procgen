/// @function collision
/// @arg xAdd
/// @arg yAdd

//Args
var _xAdd = argument[0];
var _yAdd = argument[1];

//Object Collision
var objCol = place_meeting(x + _xAdd, y + _yAdd, oCollision);

//Enemy-to-enemy collision
//if (object_index==oEnemy && place_meeting(x + _xAdd, y + _yAdd, oEnemy)){
//	return true;
//}

//Tile collision
var tileCol = tilemap_get_at_pixel(global.Tiles_Walls, bbox_left+_xAdd, bbox_top+_yAdd) or 
			  tilemap_get_at_pixel(global.Tiles_Walls, bbox_right+_xAdd, bbox_top+_yAdd) or 
			  tilemap_get_at_pixel(global.Tiles_Walls, bbox_right+_xAdd, bbox_bottom+_yAdd) or 
			  tilemap_get_at_pixel(global.Tiles_Walls, bbox_left+_xAdd, bbox_bottom+_yAdd);

//Return
return objCol or tileCol;