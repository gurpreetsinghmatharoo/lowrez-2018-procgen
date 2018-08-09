/// @arg target_x
/// @arg target_y

//Args
var _x = argument[0];
var _y = argument[1];

//Vars
var dir = point_direction(x, y, _x, _y);
var dist = 12//point_distance(x, y, _x, _y);

//Pathfinding
var line = tile_collision_line(x, y, _x, _y);

if (line){
	for(var i=0; i<180; i++){
		//Add
		var Dir = dir+i;
		
		if (!tile_collision_line(x, y, x+lengthdir_x(dist, Dir), y+lengthdir_y(dist, Dir))) return Dir;
		
		//Subtract
		var Dir = dir-i;
		
		if (!tile_collision_line(x, y, x+lengthdir_x(dist, Dir), y+lengthdir_y(dist, Dir))) return Dir;
	}
}

return dir;