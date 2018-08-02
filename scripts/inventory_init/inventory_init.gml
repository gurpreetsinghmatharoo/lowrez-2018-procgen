/// @desc Initializes inventory
/// @arg <sword>
/// @arg <bow>

inv[SWORD] = argument_count > 0 ? argument[0] : -1;
inv[BOW] = argument_count > 1 ? argument[1] : -1;