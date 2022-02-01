extends Node2D

const bullet_ressource = preload("res://scenes/fire.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("click"):
		var bullet = bullet_ressource.instance()
		add_child(bullet)
