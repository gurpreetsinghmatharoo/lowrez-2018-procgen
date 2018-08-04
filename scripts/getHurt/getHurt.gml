/// @desc Get hurt if someone hurts you

//Get attacking weapon
var inst = getAttack(x, y);

if (state!=st.dead && instance_exists(inst) && inst.parent != id && !hurtCD){ //Make sure its not your own weapon lol
	//Get its stats
	var att = inst.attack * inst.parent.attack;
	
	//HP
	hp -= att/defense;
	
	//Knockback
	var dir = point_direction(inst.x, inst.y, x, y);
	
	boostX = lengthdir_x(kbSpeed, dir);
	boostY = lengthdir_y(kbSpeed, dir);
	
	//Destroy arrow
	if (inst.object_index==oArrow){
		instance_destroy(inst);
	}
	
	//Cooldown
	hurtCD = hurtCooldown;
	
	//White alpha
	whiteAlpha = 1/defense;
}