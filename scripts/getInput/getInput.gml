////Input
///Keyboard
//Movement
global.hor = (keyboard_check(ord("D")) || keyboard_check(vk_right))-(keyboard_check(ord("A")) || keyboard_check(vk_left));
global.ver = (keyboard_check(ord("S")) || keyboard_check(vk_down))-(keyboard_check(ord("W")) || keyboard_check(vk_up));

global.run = keyboard_check_pressed(R2_VKEY);
global.runHold = keyboard_check(R2_VKEY);

global.up = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
global.upHold = keyboard_check(ord("W")) || keyboard_check(vk_up);
global.down = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);
global.downHold = keyboard_check(ord("S")) || keyboard_check(vk_down);

//Items
global.Bkey = keyboard_check_pressed(ord(B_KEY));
global.Xkey = keyboard_check_pressed(ord(X_KEY));
global.Bkeyhold = keyboard_check(ord(B_KEY));
global.Xkeyhold = keyboard_check(ord(X_KEY));
global.Akey = keyboard_check_pressed(ord(A_KEY));
global.Akeyhold = keyboard_check(ord(A_KEY));

///Gamepad controls go here


///Based on the input
global.axisDir = point_direction(0, 0, global.hor, global.ver);
global.axisDirOn = (abs(global.hor) || abs(global.ver)) ? global.axisDir : global.axisDirOn; //Only when the axis is being used

///Key hold timings
//OP Pressed (Hold time)
if (global.Bkeyhold){
	global.BPressed++;
}
else{
	global.BPressed = 0;
}

if (global.Xkeyhold){
	global.XPressed++;
}
else{
	global.XPressed = 0;
}

if (global.Akeyhold){
	global.APressed++;
}
else{
	global.APressed = 0;
}

//Down hold time
if (global.downHold){
	global.downHoldTime++;
}
else{
	global.downHoldTime = 0;
}

//Hor hold time
if (global.hor & 1){
	global.horHoldTime += global.hor;
}
else{
	global.horHoldTime = 0;
}

//Mouse... unused
global.LMB = mouse_check_button(mb_left);
global.LMBPressed = mouse_check_button_pressed(mb_left);