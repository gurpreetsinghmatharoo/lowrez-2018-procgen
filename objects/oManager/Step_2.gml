/// @description 
#region Camera
if (cameraEnabled){
	//Follow player
	var cX, cY, cW = camera_get_view_width(view_camera), cH = camera_get_view_height(view_camera);
	cX = oPlayer.x - cW/2;
	cY = oPlayer.y - cH/2;
	
	//Zoom
	var wheel = mouse_wheel_down() - mouse_wheel_up();
	
	if (zoomEnabled && abs(wheel)){
		var add = wheel * zoomSpeed;
		cW += add;
		cH += add;
		cX -= add/2;
		cY -= add/2;
	}
	
	camera_set_view_size(view_camera, cW, cH);
	camera_set_view_pos(view_camera, cX, cY);
}
#endregion