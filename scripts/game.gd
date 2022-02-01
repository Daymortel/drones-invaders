extends Node2D

const bullet_ressource = preload("res://scenes/fire.tscn")
export(PackedScene) var mob_scene

func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
		var bullet = bullet_ressource.instance()
		add_child(bullet)

func _on_MobSpawnTimer_timeout():
	randomize()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation");
	mob_spawn_location.offset = randi()

	# Create a Mob instance and add it to the scene.
	var mob = mob_scene.instance()
	add_child(mob)

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
