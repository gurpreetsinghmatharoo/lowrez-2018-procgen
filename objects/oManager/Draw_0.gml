/// @description 
//Debug base grid
//var size = DIVISION;
//var subsize = SIZE;
//for(var i=0; i<ds_list_size(debugGrids); i++){
//	var arr = debugGrids[| i];
//	var debugGrid = arr[pr.grid];
	
//	for(var X = arr[pr.x]; X < ds_grid_width(debugGrid); X++){
//		for(var Y = arr[pr.y]; Y < ds_grid_height(debugGrid); Y++){
//			//Get cell
//			var cell = debugGrid[# X, Y];
			
//			//Draw
//			draw_set_alpha(0.2);
//			draw_rectangle(X*size, Y*size, X*size+size, Y*size+size, 1);
//			draw_set_alpha(1);
		
//			//Draw sub-grid
//			if (is_array(cell)){
//				var _grid = cell[pr.grid];
//				for(var XX=0; XX<ds_grid_width(_grid); XX++){
//					for(var YY = 0; YY < ds_grid_height(_grid); YY++){
//						var cell = _grid[# XX, YY];
//						draw_set_alpha(cell/(P.COUNT-1));
//						draw_set_color(PCOL[cell]);
//						draw_rectangle(X*size + XX*subsize, Y*size + YY*subsize,
//							(X*size) + (XX*subsize+subsize)-1, (Y*size) + (YY*subsize+subsize)-1, 0);
//						draw_set_alpha(1);
//						draw_set_color(-1);
//					}
//				}
//			}
//		}
//	}
//}