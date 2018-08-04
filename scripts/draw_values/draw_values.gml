/// @arg x
/// @arg y
/// @arg name
/// @arg val
/// @arg ...

var _s = "";
for(var i=2; i<argument_count; i+=2){
	_s += argument[i] + ": " + string(argument[i+1]) + "\n";
}

draw_set_color(0);
draw_text(argument[0]+1, argument[1]+1, _s);
draw_text(argument[0]-1, argument[1]-1, _s);
draw_text(argument[0]+1, argument[1]-1, _s);
draw_text(argument[0]-1, argument[1]+1, _s);
draw_set_color(-1);
draw_text(argument[0], argument[1], _s);