var tex = sprite_get_texture(sprite_index, image_index);
var uvs = texture_get_uvs(tex);
var h = uvs[3] - uvs[1];
var yh = texture_get_texel_height(tex);
shader_set_uniform_f(global.uniHeight, h/yh);