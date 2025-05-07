extends Node3D

@export var prefab_conserve: PackedScene  # La scène de la conserve de lasagne (à assigner dans l'éditeur)
@export var max_conserves: int = 10  # Nombre max de conserves dans la zone
@export var zone_size: Vector3 = Vector3(1, 1, 1)  # Taille de la zone de spawn

var conserves = []  # Liste des conserves dans la zone

func _ready():
	spawn_initial_conserves()

func spawn_initial_conserves():
	for i in range(Data.get_food()):
		add_conserve()

func add_conserve():
	if conserves.size() >= max_conserves:
		return  # Empêche de dépasser la limite

	var max_attempts = 10  # Nombre d'essais pour trouver un bon emplacement
	var min_spacing = 1  # Distance minimale entre chaque conserve
	var new_pos = Vector3.ZERO

	for i in range(max_attempts):
		new_pos = Vector3(
			randf_range(-zone_size.x/2, zone_size.x/2),
			0,
			randf_range(-zone_size.z/2, zone_size.z/2)
		)

		var too_close = false
		for conserve in conserves:
			if conserve.position.distance_to(new_pos) < min_spacing:
				too_close = true
				break  # Arrête la vérification dès qu'une conserve est trop proche

		if not too_close:
			break  # On a trouvé une bonne position

	# Instancier la conserve si elle est bien placée
	var conserve = prefab_conserve.instantiate()
	conserve.position = new_pos
	$conserve.add_child(conserve)
	conserves.append(conserve)
	Data.set_food(conserves.size())

func remove_conserve():
	if conserves.size() > 0:
		var conserve = conserves.pop_front()  # Retire la plus ancienne conserve
		conserve.queue_free()

func update_conserves(amount: int):
	if amount > 0:
		for i in range(amount):
			add_conserve()
	elif amount < 0:
		for i in range(-amount):
			remove_conserve()
