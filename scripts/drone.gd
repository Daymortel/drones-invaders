extends RigidBody2D

onready var game_node = get_node("..")

func explode():
	game_node.add_score(100)
	queue_free()
