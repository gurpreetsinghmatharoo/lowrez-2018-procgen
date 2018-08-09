/// @arg min
/// @arg max

//Args
var _min = argument[0];
var _max = argument[1];

//Create array
var arr = [];
for(var i=0; i<sword.count; i++){
	var level = swStats[i, swst.level];
	if (level <= _max && level >= _min){
		arr[array_length_1d(arr)] = i;
	}
}

return arr[irandom(array_length_1d(arr)-1)];