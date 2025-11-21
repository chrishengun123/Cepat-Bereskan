shader_type canvas_item;

uniform sampler2D dirt_mask;

void fragment() {
	// Sample the base dirt texture
	vec4 base = texture(TEXTURE, UV);

	// Sample the mask (pixel accurate)
	ivec2 mask_size = textureSize(dirt_mask, 0);
	vec2 mask_uv = (floor(UV * vec2(mask_size)) + 0.5) / vec2(mask_size);
	vec4 mask = texture(dirt_mask, mask_uv);

	// Multiply alpha by mask (r = 1 dirty, r = 0 clean)
	float final_alpha = base.a * mask.r;
	COLOR = vec4(base.rgb, final_alpha);
}

