shader_type spatial;

const vec3 magic = vec3(0.06711056f, 0.00583715f, 52.9829189f);
uniform vec4 color: source_color = vec4(1.0, 1.0, 1.0, 0.5);

void fragment() {
	ALBEDO.rgb = color.rgb;
	if (color.a < 0.001 || color.a < fract(magic.z * fract(dot(FRAGCOORD.xy, magic.xy)))) {
		discard;
	}
}