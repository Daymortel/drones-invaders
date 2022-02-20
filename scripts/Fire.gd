extends KinematicBody2D

var velocity = Vector2()
const speed = 15
var orientation
onready var mouse_pos = null

func _ready():
	set_position(get_node("/root/Node2D/Player").get_position())
	mouse_pos = get_local_mouse_position()
	if get_node("../Player/AnimatedSprite").flip_h:
		orientation = true
		$Sprite.flip_h = true
	else:
		orientation = false

func _physics_process(delta):
	velocity = velocity.move_toward(mouse_pos, delta)
	velocity = velocity.normalized() * speed
	position = position + velocity

func _on_Area2D_body_entered(body):
	body.explode()
