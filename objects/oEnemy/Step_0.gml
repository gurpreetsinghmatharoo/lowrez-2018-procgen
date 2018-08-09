/// @description 
switch (state){
	case st.idle: case st.move:
		//Vars
		var inputX = 0, inputY = 0, run = 0// && stamina>0;
		, attack = 0;
		
		//Activity switch
		switch (activity){
			//Roam
			case act.roam:
				//Detect player
				var dir = moveDir * 90;
				var pDir = point_direction(x, y, oPlayer.x, oPlayer.y);
				var pDist = distance_to_object(oPlayer);
				var diff = abs(angle_difference(dir, pDir));
				
				if (diff < detectAngle && pDist < detectRange){
					var nDir = dir_to_point(oPlayer.x, oPlayer.y);
					var mDir = dir + angle_difference(nDir, dir)*0.8;
					
					inputX = lengthdir_x(1, mDir);
					inputY = lengthdir_y(1, mDir);
					
					//Attack
					if (collision_circle(x, y, 8, oPlayer, 0, 0)){
						attack = 1;
					}
					
					image_blend = c_red;
				}
				//Roam
				else{
					//Is leader?
					if (leader==noone){
						//Select new
						if (targetX==undefined || point_distance(x, y, targetX, targetY) < 32){
							var aX = floor(x/AREA)*AREA;
							var aY = floor(y/AREA)*AREA;
						
							targetX = floor(aX + irandom(AREA-1));
							targetY = floor(aY + irandom(AREA-1));
						}
						
						//Move
						//var tDir = point_direction(x, y, targetX, targetY);
						var nDir = dir_to_point(targetX, targetY);
						var mDir = dir + angle_difference(nDir, dir)*0.8;
					
						inputX = lengthdir_x(1, mDir);
						inputY = lengthdir_y(1, mDir);
					
						image_blend = c_green;
					}
					//Is follower?
					else{
						//var tDir = point_direction(x, y, leader.x, leader.y);
						var nDir = dir_to_point(leader.x, leader.y);
						var mDir = dir + angle_difference(nDir, dir)*0.8;
					
						inputX = lengthdir_x(1, mDir);
						inputY = lengthdir_y(1, mDir);
					
						image_blend = c_blue;
					}
				}
			break;
			
			//Guard a fort
			case act.guard:
			
			break;
		}

		//Movement
		moveX = inputX * moveSpeed * (1+run*runSpeed) + round(boostX);
		moveY = inputY * moveSpeed * (1+run*runSpeed) + round(boostY);
		
		//Collisions
		if (collision(moveX, 0)){
			//while(!collision(sign(moveX), 0)){
			//	x += sign(moveX);
			//}
			
			moveX = 0;
		}
		
		if (collision(0, moveY)){
			//while(!collision(0, sign(moveY))){
			//	y += sign(moveY);
			//}
			
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
		if (abs(inputX) || abs(inputY)) moveDir = round(point_direction(0, 0, inputX, inputY)/90) mod 4;
		
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
sprite_index = sprites[state, moveDir];
mask_index = sprites[st.idle, 3];

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