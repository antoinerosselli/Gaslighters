shader_type canvas_item;

// Couleur de base du ColorRect
uniform vec4 baseColor : source_color = vec4(1.0);

// Contrôle de la fonte (valeur entre 0 et 1)
uniform float dissolveSlider : hint_range(0.0, 1.0) = 0.0;
uniform float holeScale : hint_range(5.0, 50.0) = 15.0;  // Taille des trous
uniform float holeDensity : hint_range(0.5, 5.0) = 1.5;  // Densité des trous

// Contours lumineux des trous
uniform vec4 edgeColor : source_color = vec4(1.0, 0.5, 0.0, 1.0); // Couleur des bords (feu/lave)
uniform float edgeThickness : hint_range(0.0, 0.5) = 0.08; // Épaisseur des bords
uniform float edgeGlowIntensity : hint_range(1.0, 10.0) = 5.0; // Intensité du glow

// Animation
uniform bool enable_dissolve_animation = false;
uniform float animation_speed : hint_range(0.0, 5.0, 0.1) = 1.0;

// Fonction de bruit interpolé (plus fluide que le bruit simple)
float smooth_random(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float interpolated_noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = smooth_random(i);
    float b = smooth_random(i + vec2(1.0, 0.0));
    float c = smooth_random(i + vec2(0.0, 1.0));
    float d = smooth_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f); // Interpolation lissée

    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
    vec2 uv = UV * holeScale; // Ajuste la taille des trous

    // Ajout d'une distorsion des UVs pour éviter un effet trop structuré
    uv += vec2(sin(uv.y * 10.0 + TIME * 0.5), cos(uv.x * 10.0 + TIME * 0.5)) * 0.05;

    // Génération du bruit avec plusieurs couches pour un effet plus naturel
    float noise1 = interpolated_noise(uv * holeDensity);
    float noise2 = interpolated_noise(uv * (holeDensity * 0.5)) * 0.5;
    float noise3 = interpolated_noise(uv * (holeDensity * 2.0)) * 0.3;

    float holePattern = (noise1 + noise2 + noise3) / 1.8;

    // Animation optionnelle du bruit (les trous "bougent" légèrement)
    if (enable_dissolve_animation) {
        float timeFactor = TIME * animation_speed * 0.2;
        vec2 movingUV = uv + vec2(sin(timeFactor), cos(timeFactor)) * 0.05;
        holePattern = interpolated_noise(movingUV * holeDensity);
    }

    // Calcul de la dissolution
    float dissolveFactor = step(holePattern, dissolveSlider);

    // Détection des BORDS UNIQUEMENT (zone fine entre trou et intact)
    float edgeZone = smoothstep(dissolveSlider - edgeThickness, dissolveSlider, holePattern) 
                   - smoothstep(dissolveSlider, dissolveSlider + edgeThickness, holePattern);

    // Application de la couleur des bords SEULEMENT DANS CETTE ZONE
    vec3 finalColor = baseColor.rgb * dissolveFactor; // Fond normal
    finalColor += edgeColor.rgb * edgeGlowIntensity * edgeZone; // Bords lumineux uniquement

    // Application de la transparence
    COLOR = vec4(finalColor, dissolveFactor * baseColor.a + edgeZone * 0.5);
}
