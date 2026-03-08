shader_type canvas_item;

uniform float scale;
uniform vec4 colour_one : source_color;
uniform vec4 colour_two : source_color;

uniform vec2 target_point = vec2(0.5,0.5);

varying vec2 pos;
void vertex(){
	pos = VERTEX;
}

void fragment() {
	float id = sin((pos.y + pos.x) * scale);
	if (id < 0.0){
		COLOR = colour_one;
	}else{
		COLOR = colour_two;
	}
}