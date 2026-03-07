shader_type spatial;

uniform sampler2D albedo;

uniform bool apply_pixels = true;

group_uniforms ScreenUV;
uniform vec2 uv_scale;
uniform vec2 uv_offset;

group_uniforms ScreenEffect;
uniform float scale;
uniform float screen_intensity : hint_range(0.0, 1.0, 0.1);

group_uniforms BloomEffect;
uniform float bloom_intensity : hint_range(0.0, 1.0, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

vec3 get_screen_pixel_colour(vec2 uv, vec3 colour){
	vec3 base_colour = colour * (1.0-screen_intensity);
	int id = int(mod(floor(uv.x * scale) + uv.y * scale, 3));
	switch (id){
		case 0:
			return base_colour + vec3(colour.r,0,0)*screen_intensity;
		case 1:
			return base_colour + vec3(0,colour.g,0)*screen_intensity;
		case 2:
			return base_colour + vec3(0,0,colour.b)*screen_intensity;
	}
}

void fragment() {
	vec2 adjusted_uv = vec2(UV.x * uv_scale.x, UV.y * uv_scale.y) + uv_offset;
	vec3 colour = texture(albedo, adjusted_uv).rgb;
	if(apply_pixels){
		ALBEDO = get_screen_pixel_colour(adjusted_uv, colour);
	}
	else{
		ALBEDO = colour;
	}
	
	EMISSION = ALBEDO * (1.0 + bloom_intensity);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
