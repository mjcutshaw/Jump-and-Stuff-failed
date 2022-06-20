shader_type canvas_item;

uniform float blur: hint_range(0.0, 5);
uniform float brightness: hint_range(0.0, 1.0, 0.1);

void fragment(){
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV, blur);
	COLOR.rgb *= brightness;
}