/// @description 
#region Camera
if (cameraEnabled){
	var cX, cY, cW = camera_get_view_width(view_camera), cH = camera_get_view_height(view_camera);
	cX = cameraX - cW/2;
	cY = cameraY - cH/2;
	cX = clamp(cX, 0, room_width-cW);
	cY = clamp(cY, 0, room_height-cH);

	camera_set_view_pos(view_camera, cX, cY);
}
#endregion