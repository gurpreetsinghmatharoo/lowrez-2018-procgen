/// @description 
if (object_index != oDepth) exit;

//Depth list
var dpList = ds_list_create();
var camMarg = 32;

var camX1 = camera_get_view_x(view_camera)-camMarg;
var camY1 = camera_get_view_y(view_camera)-camMarg;
var camX2 = camX1 + camera_get_view_width(view_camera) + camMarg*2;
var camY2 = camY1 + camera_get_view_height(view_camera) + camMarg*2;

with (all){
	if (visible && sprite_exists(sprite_index) 
		&& rectangle_in_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, camX1, camY1, camX2, camY2)){ //Is it in view?
		ds_list_add(dpList, id | (bbox_bottom << 32));
	}
}

ds_list_sort(dpList, true);

//Draw
for(var i=0; i<ds_list_size(dpList); i++){
	var entry = dpList[| i];
	var _id = entry & $ffffffff;
	
	with (_id){
		if (outlineWidth) outline_start(outlineWidth, outlineColor, sprite_index, 4, 0, whiteAlpha);
		
		//Different draw event types
		switch(object_index){
			default: draw_self();
		}
		
		if (outlineWidth) outline_end();
	}
}

//Free
ds_list_destroy(dpList);