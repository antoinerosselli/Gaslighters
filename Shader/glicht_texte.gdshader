shader_type canvas_item;

uniform float time : hint_range(0.0, 100.0);
uniform float glitch_intensity : hint_range(0.0, 1.0) = 0.2;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec2 uv = FRAGCOORD.xy;

	// Ajoute une distorsion horizontale aléatoire
	float glitch = sin(uv.y * 10.0 + time * 50.0) * glitch_intensity;

	// Petits déplacements aléatoires de couleur (R, G, B split)
	vec2 offset = vec2(glitch, 0.0);
	COLOR.r = texture(SCREEN_TEXTURE, SCREEN_UV + offset).r;
	COLOR.g = texture(SCREEN_TEXTURE, SCREEN_UV - offset).g;
	COLOR.b = texture(SCREEN_TEXTURE, SCREEN_UV + offset * 0.5).b;
	COLOR.a = texture(SCREEN_TEXTURE, SCREEN_UV).a;
}