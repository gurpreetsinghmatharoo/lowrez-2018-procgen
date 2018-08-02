/// @description 
//Outline
outline_set(0, O_NORMAL);

//Destroy if colliding
if (place_meeting(x, y, oPlaceable) || place_meeting(x, y, oPlayer)){
	instance_destroy();
}