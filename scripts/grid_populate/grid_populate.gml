/// @arg grid_arr
/// @arg <[types]
/// @arg type>

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
	for(var X = 0; X < ds_grid_width(_grid); X++){
		for(var Y = 0; Y < ds_grid_height(_grid); Y++){
			//Get cell
			var cell = _grid[# X, Y];
			
			//Loop through types
			for(var i=0; i<A.COUNT; i++){
				var chance = AC[i];
				
				//Set cell at chance
				if (irandom(100) < chance && cell==0){
					//Set to area type
					cell = i;
					
					//Add grid and populate it
					var grid_arr = grid_init(_x + X*DIVISION, _y + Y*DIVISION, DIVISION, DIVISION, SIZE);
					grid_populate(grid_arr, PL[cell], cell);
					_grid[# X, Y] = grid_arr; //Debug
					
					//End
					break;
				}
			}
		}
	}
	
	//Replace empty ones with land
	for(var X = 0; X < ds_grid_width(_grid); X++){
		for(var Y = 0; Y < ds_grid_height(_grid); Y++){
			//Get cell
			var cell = _grid[# X, Y];
			
			if (cell==0){
				//Set to area type
				cell = A.LAND;
					
				//Add grid and populate it
				var grid_arr = grid_init(_x + X*DIVISION, _y + Y*DIVISION, DIVISION, DIVISION, SIZE);
				grid_populate(grid_arr, PL[cell], cell);
				_grid[# X, Y] = grid_arr; //Debug
			}
		}
	}
}
//Sub-grid
else{
	//Args
	var tArr = argument[1];
	var orgType = argument[2];
	
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
									var xAdd=0, yAdd=0;
									if (irandom(1)) xAdd = (w+2) * choose(-1, 1);
									else yAdd = (h+2) * choose(-1, 1);
									
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
}

//Destroy
//ds_grid_destroy(_grid); Debug