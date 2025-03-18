shader_type canvas_item;

uniform float scale : hint_range(0.1, 10.0) = 5.0;
uniform float speed : hint_range(0.1, 5.0) = 0.3; // Vitesse du mouvement
uniform int octaves : hint_range(1, 8) = 6;
uniform float persistence : hint_range(0.1, 1.0) = 0.6;
uniform vec4 color_1 : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Noir
uniform vec4 color_2 : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Blanc

// Fonction de hachage améliorée pour générer du bruit pseudo-aléatoire
float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 78.233);
    return fract(p.x * p.y);
}

// Fonction de bruit lissé pour éviter les motifs visibles
float smooth_noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);

    float a = hash(i + vec2(0.0, 0.0));
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// Fractal Brownian Motion (FBM) amélioré avec du mouvement
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 1.0;
    float frequency = 2.0;

    for (int i = 0; i < octaves; i++) {
        value += smooth_noise(p * frequency) * amplitude;
        frequency *= 2.0;
        amplitude *= persistence;
    }

    return value;
}

void fragment() {
    vec2 uv = UV * scale;

    // Ajout du mouvement en faisant défiler les coordonnées UV
    vec2 moving_uv = uv + vec2(TIME * speed * 0.2, TIME * speed * 0.1);

    // Distorsion dynamique pour un effet plus organique
    vec2 distortion = vec2(
        fbm(moving_uv + vec2(0.1, 0.1)) - 0.5,
        fbm(moving_uv - vec2(0.1, 0.1)) - 0.5
    );

    moving_uv += distortion * 0.2; // Ajuste la force de la distorsion

    // Génération du bruit avec un effet fluide
    float noise_value = fbm(moving_uv);

    // Mélange entre les couleurs pour un rendu animé
    vec4 final_color = mix(color_1, color_2, noise_value);

    COLOR = final_color;
}
