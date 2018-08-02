/// @description 
//Destroy
if (playerAttacking(x, y)){
	instance_destroy();
	partLeaf(x+sprite_width/2, y+sprite_height/4, irandom_range(8, 15));
}