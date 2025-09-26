shader_type canvas_item;

uniform bool active = true;
uniform vec4 colour : source_color = vec4(1, 1, 1, 1);
uniform float trans : hint_range(0.0, 1.0) = 0.8;

void fragment() {
	vec4 previousColour = texture(TEXTURE, UV);
	vec4 coolColour = mix(previousColour, colour, trans);
	coolColour *= previousColour.a;
	vec4 newColour = previousColour;
	if (active == true){
		newColour = coolColour;
	}
	COLOR = newColour;
}
