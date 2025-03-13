extends Camera3D

# Paramètres pour le mouvement de la caméra
var noise := FastNoiseLite.new()
@export var amplitude := 0.001  # Amplitude du tremblement, réduite pour un effet subtil
var time := 0.0  # Temps écoulé

# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = randi()
	noise.frequency = 2.0  # Fréquence plus élevée pour des changements rapides
	noise.noise_type = 3  # Bruit de Perlin pour un mouvement lisse

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	# Utiliser le bruit pour calculer les décalages en X et Y
	var x_offset = noise.get_noise_2d(time, 0.0) * amplitude
	var y_offset = noise.get_noise_2d(time, 1.0) * amplitude
	
	# Appliquer le déplacement à la position de la caméra
	position.x += x_offset
	position.y += y_offset
