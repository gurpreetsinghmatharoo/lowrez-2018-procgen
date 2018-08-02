/// @arg x
/// @arg y
/// @arg count

//Args
var _x = argument[0];
var _y = argument[1];
var _count = argument[2];

//Function
repeat(_count){
	var rotRange = 3;
	part_type_orientation(PLEAF, 0, 360, random_range(-rotRange, rotRange), 0, 0);
	var dirRange = 3;
	part_type_direction(PLEAF, -140, -40, random_range(-rotRange, rotRange), 0);

	part_particles_create(global.pSys, _x, _y, PLEAF, 1);
}