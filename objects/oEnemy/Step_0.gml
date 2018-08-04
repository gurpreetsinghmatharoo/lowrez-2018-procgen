/// @description 
switch (state){
	case st.idle: case st.move:
		//Input
		var inputX, inputY;
		inputX = 0;
		inputY = 0;
		
		var run = 0 && stamina>0;
		var attack = 0;

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
		
		//Direction
		if (abs(inputX) || abs(inputY)) moveDir = point_direction(0, 0, inputX, inputY) div 90;
		
		//Attack
		if (attack && inv[SWORD]>=0){
			state_set(st.attack);
			state_sword(inv[SWORD]);
			move_sword();
		}
		
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
		move_sword();
		
		//End
		if (animation_end()){
			state_set(st.idle);
			image_speed = 0;
			instance_destroy(mySword);
		}
	break;
	
	case st.dead:
		image_alpha = 0.5;
		
		if (animation_end()){
			image_speed = 0;
			image_index = image_number-1;
		
			alarm[0] = 60;
		}
	break;
}

//Sprite
//sprite_index = sprites[state, moveDir];

//Boost
boostX = lerp(boostX, 0, 0.1);
boostY = lerp(boostY, 0, 0.1);

//Move CD
moveCD -= moveCD>0;

//White alpha
whiteAlpha -= (whiteAlpha > 0)/10;

//Hurt CD
hurtCD -= hurtCD>0;

//Get hurt
getHurt();

//Die
if (hp<=0 && state!=st.dead && !abs(boostX) && !abs(boostY)){
	state_set(st.dead);
}