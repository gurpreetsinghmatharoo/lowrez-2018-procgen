/// @description 
//Get input
getInput();

//Previous area coordinates
areaPrevX = areaX;
areaPrevY = areaY;

//Deactivate out-of-focus instances
var camMarg = CAM.W;

var camX1 = camera_get_view_x(view_camera)-camMarg;
var camY1 = camera_get_view_y(view_camera)-camMarg;
var camX2 = camX1 + camera_get_view_width(view_camera) + camMarg*2;
var camY2 = camY1 + camera_get_view_height(view_camera) + camMarg*2;

instance_activate_region(camX1, camY1, camX2-camX1, camY2-camY1, true);
instance_deactivate_region(camX1, camY1, camX2-camX1, camY2-camY1, false, true);
//instance_activate_object(oPlayer);
instance_activate_object(depthManager);
instance_activate_object(oGenerated);