/// @arg Moves the sword

var arr = SCS[moveDir, floor(image_index)];
mySword.x = x + arr[SC.X];
mySword.y = y + arr[SC.Y];
mySword.image_angle = arr[SC.ANGLE];