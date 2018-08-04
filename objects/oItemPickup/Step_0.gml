/// @description 
//Collide
if (collision_circle(x, y, 8, oPlayer, 0, 0)){
	col = true;
	outlineColor = O_HIGHLIGHT;
}
else{
	col = false;
	outlineColor = O_SWORD;
}

//Pick up
if (col && global.Akey){
	//Set
	oPlayer.inv[type] = item;
	
	//HUD Show Time
	global.showTime = room_speed*2;
	
	//Remove
	instance_destroy();
}