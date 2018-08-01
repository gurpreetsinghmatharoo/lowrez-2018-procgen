/// @description 
switch (state){
	case st.idle: case st.move:
		//Input
		var inputX, inputY;
		inputX = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
		inputY = (keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up));
		
		var run = keyboard_check(vk_shift) && stamina>0;
		var attack = keyboard_check_pressed(vk_space);

		//Movement
		moveX = inputX * moveSpeed * (1+run*runSpeed) + round(boostX);
		moveY = inputY * moveSpeed * (1+run*runSpeed) + round(boostY);
		
		//Collisions
		if (collision(moveX, 0)){
			while(!collision(sign(moveX), 0)){
				x += sign(moveX);
			}
			
			moveX = 0;
		}
		
		if (collision(0, moveY)){
			while(!collision(0, sign(moveY))){
				y += sign(moveY);
			}
			
			moveY = 0;
		}
		
		//log("inputX: " + string(inputX) + ", inputY: " + string(inputY) + 
		//	" | moveX: " + string(moveX) + ", moveY: " + string(moveY));

		//Apply
		if (!moveCD){
			x += moveX;
			y += moveY;
			
			moveCD = moveDelay;
		}

		//State
		if (abs(moveX)+abs(moveY)==0){
			state = st.idle;
		}
		else{
			state = st.move;
			
			image_speed = 1+run/2;
		}
		
		//mask_index = sPlayer_Mask;
		
		//Direction
		if (state==st.move) moveDir = point_direction(0, 0, moveX, moveY) div 90;
		
		//Attack
		//if (attack){
		//	state_set(st.attack);
		//}
		
		//Enemy Collision
		//var enemy = instance_place(x, y, oEnemies);
		
		//if (enemy && enemy.state==st.attack){
		//	var dir = point_direction(enemy.x, enemy.y, x, y);
		//	boostX = lengthdir_x(8, dir);
		//	boostY = lengthdir_y(8, dir);
			
		//	hp -= enemy.attack;
		//}
		
		//Stamina
		if (run){
			stamina-=2;
			staminaRefill = 60;
		}
		else if (stamina<100 && staminaRefill<=0){
			stamina+=2;
		}
		
		if (staminaRefill > 0) staminaRefill--;
	break;
	
	case st.attack:
		image_speed = 1;
		mask_index = sprite_index;
	break;
}

//Door
//var door = instance_place(x, y, oDoor);
//if (door && door.touched){
//	y--;
	
//	state = st.move;
//	moveDir = 1;
//}

//Sprite
//sprite_index = sprites[state, moveDir];

//Boost
boostX = lerp(boostX, 0, 0.1);
boostY = lerp(boostY, 0, 0.1);

//Move CD
moveCD -= moveCD>0;

//Die
if (hp<=0 && state!=st.dead){
	state_set(st.dead);
}