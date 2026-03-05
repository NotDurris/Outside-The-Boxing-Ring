shader_type canvas_item;

uniform float time_scale;
uniform float scale;
uniform float dot_scale : hint_range(1.0, 2.0, 0.05);
uniform vec4 colour_one : source_color;
uniform vec4 colour_two : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 scrolling_uv = UV + TIME * time_scale;
	float id = sin(scrolling_uv.y * scale) + cos(scrolling_uv.x * scale);
	float center_distance = 1.0 + length(UV - vec2(0.5,0.5));
	if (id < dot_scale * center_distance){
		COLOR = colour_one;
	}else{
		COLOR = colour_two;
	}
}