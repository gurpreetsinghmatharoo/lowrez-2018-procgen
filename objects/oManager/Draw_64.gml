/// @description 
//Vars
var _y1 = round(y1);
var _y2 = round(y2);

//HUD Weapons
draw_sprite(sHUDWeapons, 0, 0, _y2-CAM.H);
draw_sprite(sHUDWeapons, 1, 0, _y1);

//Sword
if (oPlayer.inv[SWORD]>=0) {
	//Get sprite
	var spr = swStats[oPlayer.inv[SWORD], swst.sprite];
	
	//Calculate coordinates for centering
	var _x = 6;
	var _y = _y2 - 6;
	var _w = sprite_get_width(spr);
	var _h = sprite_get_height(spr)
	var _xoff = sprite_get_xoffset(spr);
	var _yoff = sprite_get_yoffset(spr);
	
	//Draw with outline
	outline_start(1, O_SWORD, spr, 4);
	draw_sprite(spr, 0, _x + (_xoff - _w/2), _y + (_yoff - _h/2));
	outline_end();
}

//XP/Level
if (instance_exists(oPlayer)){
	//Draw XP Bar
	var _x = CAM.W - 49;
	var _y = _y1 + 1;
	
	draw_sprite(sXPBar, 0, _x, _y);
	draw_sprite_part(sXPBar, 0, 0, 0, (oPlayer.xp/global.reqXP)*48, 48, _x, _y);
	
	//Draw level
	_x = 6;
	_y = _y1 + 6;
	
	draw_text_center(_x, _y, oPlayer.level);
}