shader_type canvas_item;

uniform vec3 modulate = vec3(1.0);
uniform bool enabled = false;
uniform vec4 line_color : source_color = vec4(1.0);
uniform float thickness = 2.0;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR.rgb = COLOR.rgb * modulate;
	if (enabled){
		vec2 size = TEXTURE_PIXEL_SIZE * thickness;
		float outline = 0.0;
		
		for (int i = 0; i < OFFSETS.length(); i++) {
			outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
		}
		outline = min(outline, 1.0);
		
		vec4 color = texture(TEXTURE, UV);
		COLOR = mix(color, line_color, outline - color.a);
	}
}