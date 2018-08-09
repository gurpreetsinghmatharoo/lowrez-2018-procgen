/// @arg grid_arr
/// @arg <[types]
/// @arg type
/// @arg climate>

//Args
var _arr = argument[0];

//Vars
var _grid = _arr[pr.grid];
var _x = _arr[pr.x];
var _y = _arr[pr.y];

/// Function
//Base grid
if (argument_count==1){
	//Loops
	var prevClimate = CL.NORMAL;
	
	for(var X = 0; X < ds_grid_width(_grid); X++){
		for(var Y = 0; Y < ds_grid_height(_grid); Y++){
			//Get cell
			var cell = _grid[# X, Y];
				
			//Set climate
			var climate = choose(prevClimate, -1, -1); //Previous climate, or new climate x2
				
			if (climate==-1){
				//Loop through all climates and select one
				for(var i=1; i<CL.COUNT; i++){
					if (irandom(100) < CLC[i]){
						climate = i;
						break;
					}
				}
					
				//If none got selected, just use the normal one
				if (climate==-1){
					climate = CL.NORMAL;
				}
			}
					
			//Set background tiles
			var arr = layers_get(floor(_x/AREA), floor(_y/AREA));
			var tmback = arr[1];
				
			var sx = _x+X*DIVISION;
			var sy = _y+Y*DIVISION;
			var sw = DIVISION;
			var sh = DIVISION;
			for(var xx=sx; xx<sx+sw; xx+=SIZE){
				for(var yy=sy; yy<sy+sh; yy+=SIZE){
					tilemap_set_at_pixel(tmback, climate*10 + 1, xx, yy);
				}
			}
				
			prevClimate = climate;
			
			//Loop through types
			for(var i=0; i<=A.COUNT; i++){
				var chance = AC[i];
				
				//Set cell at chance
				if (irandom(100) < chance && cell==0){
					if (i==A.COUNT) i = A.LAND; //Place land at last one
					
					//Set to area type
					cell = i;
					
					//Add grid and populate it
					var grid_arr = grid_init(_x + X*DIVISION, _y + Y*DIVISION, DIVISION, DIVISION, SIZE);
					grid_populate(grid_arr, PL[cell], cell, climate); //Passing the important info here
					
					//End
					break;
				}
			}
		}
	}
	
	//Replace empty ones with land
	//for(var X = 0; X < ds_grid_width(_grid); X++){
	//	for(var Y = 0; Y < ds_grid_height(_grid); Y++){
	//		//Get cell
	//		var cell = _grid[# X, Y];
			
	//		if (cell==0){
	//			//Set to area type
	//			cell = A.LAND;
					
	//			//Add grid and populate it
	//			var grid_arr = grid_init(_x + X*DIVISION, _y + Y*DIVISION, DIVISION, DIVISION, SIZE);
	//			grid_populate(grid_arr, PL[cell], cell, climate);
	//			_grid[# X, Y] = grid_arr; //Debug
	//		}
	//	}
	//}
}
//Sub-grid
else{
	//Args
	var tArr = argument[1];
	var orgType = argument[2];
	var climate = argument[3];
	
	//Vars
	var areax = floor(_x/AREA);
	var areay = floor(_y/AREA);
	
	var arr = layers_get(areax, areay);
	var tmback = arr[1];
	
	var inx = _x - areax*AREA;
	var iny = _y - areay*AREA;
	
	//Count
	var count, i=0;
	repeat(P.COUNT) count[i++] = 0;
	
	//Loops
	var gW = ds_grid_width(_grid);
	var gH = ds_grid_height(_grid);
	for(var X = 0; X < gW; X++){
		for(var Y = 0; Y < gH; Y++){
			//Get cell
			var cell = _grid[# X, Y];
			
			//Loop through types
			for(var i=0; i<array_length_1d(tArr); i++){
				var type = tArr[i];
				var chance = PC[orgType, type];
				
				//Set cell at chance
				if (irandom(1000) < chance && cell==0 && (count[type]<PCN[type] || PCN[type]==-1)){
					//Place
					var placed = placeable_place(_grid, type, X, Y, count);
					
					if (is_array(placed)){
						//Data
						var w = placed[0];
						var h = placed[1];
						
						//Place extra
						var extra = irandom(max(PCN[type]-count[type], 0));
						
						repeat (extra){
							switch(type){
								//House
								case P.HOUSE:
									var xAdd=0, yAdd=0, marg=PM[type];
									if (irandom(1)) xAdd = (w+marg) * choose(-1, 1);
									else yAdd = (h+marg) * choose(-1, 1);
									
									placeable_place(_grid, type, X+xAdd, Y+yAdd, count);
								break;
							}
						}
						
						//End
						break;
					}
				}
			}
		}
	}
	
	//Place instances/tiles
	for(var X = 0; X < gW; X++){
		for(var Y = 0; Y < gH; Y++){
			//Get cell
			var cell = _grid[# X, Y];
			
			//Place instances
			var obj = PO[cell];
			if (cell>0 && object_exists(obj)){
				instance_create_layer(_x + X*SIZE, _y + Y*SIZE, "Instances", obj);
			}
			else{
				switch (cell){
					//Build camp area
					case P.FORT:
						
					break;
				}
			}
				
			//Background Tiles
			var place = irandom(100) < 20;
			
			if (place){
				var td = climate*10 + irandom_range(2, 9);
				tilemap_set(tmback, td, inx/SIZE + X, iny/SIZE + Y);
			}
		}
	}
	
	//Enemy groups to place
	var enemyCount = irandom_range(1, 3);
	var maxGroupSize = floor(irandom_range(6, 12)/max(enemyCount, 1));
	var dist = 16;
	var baseDist = dist;
	
	var count = 0;
	
	do{
		//Group position
		do {
			var eX = irandom_range(0, gW);
			var eY = irandom_range(0, gH);
			
			var rX = (_x + eX*SIZE) + SIZE/2;
			var rY = (_y + eY*SIZE) + SIZE/2;
		} until (point_distance(rX, rY, oPlayer.x, oPlayer.y) > CAM.W)
		
		//Type
		var type;
		switch(orgType){
			
			default: type = enemy.bandit; //For now
		}
		
		//Create
		var groupSize = irandom_range(1, maxGroupSize);
		var insts = [];
		for(var i=0; i<groupSize; i++){
			insts[i] = noone;
			dist = baseDist;
			
			//Select enemy position
			var tries = 0;
			do {
				var xx = rX + lengthdir_x(dist, random(360));
				var yy = rY + lengthdir_y(dist, random(360));
				
				//Make sure the loop doesn't go infinite - expand the range or end the loop
				tries++;
				if (tries > 10) dist += 4;
				//if (tries > 16) break;
			} until (!collision_circle(xx, yy, 4, oEnemy, 0, 0) && !collision_circle(xx, yy, 4, oCollision, 0, 0));
			
			var inst = spawnEnemy(xx, yy, type, oPlayer.level, act.roam);
			insts[i] = inst;
			
			/// Set loadout
			//Sword
			inst.inv[SWORD] = sword_level_range(max(1, oPlayer.level-5), oPlayer.level);
		}
		
		//Select leader
		do {
			var leader = insts[irandom(groupSize-1)];
		} until (instance_exists(leader))
		
		for(var i=0; i<groupSize; i++){
			if (instance_exists(insts[i]) && insts[i] != leader) insts[i].leader = leader;
		}
		
		//Increase count
		count++;
	} until (count>=enemyCount);
}

//Destroy
ds_grid_destroy(_grid);