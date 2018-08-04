/// @description 
//Outline
outline_set(0, O_NORMAL);

//Destroy if colliding
var marg = CAM.W/2;
if (place_meeting(x, y, oPlaceable) || collision_rectangle(x-marg, y-marg, x+marg, y+marg, oPlayer, 0, 0)){
	instance_destroy();
}
else{
	mask_index = sprite_index;
}

whiteAlpha = 0;