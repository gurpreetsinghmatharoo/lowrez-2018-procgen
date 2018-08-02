/// @description 
if (object_index != oDepth) exit;

//Depth list
var dpList = ds_list_create();

with (all){
	if (visible && sprite_exists(sprite_index)){
		ds_list_add(dpList, id | (bbox_bottom << 32));
	}
}

ds_list_sort(dpList, true);

//Draw
for(var i=0; i<ds_list_size(dpList); i++){
	var entry = dpList[| i];
	var _id = entry & $ffffffff;
	
	with (_id){
		if (outlineWidth) outline_start(outlineWidth, outlineColor, sprite_index, 4, 0);
		
		switch(object_index){
			default: draw_self();
		}
		
		
		if (outlineWidth) outline_end();
	}
}


//Free
ds_list_destroy(dpList);