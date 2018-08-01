/// @description 
switch (state){
	case st.attack:
		state_set(st.idle);
	break;
	
	case st.dead:
		image_speed = 0;
		image_index = image_number-1;
		
		alarm[0] = 60;
	break;
}