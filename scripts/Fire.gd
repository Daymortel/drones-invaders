extends KinematicBody2D

var velocity = Vector2()
var speed = 700
var orientation

func _ready():
	set_position(get_node("/root/Node2D/Player").get_position())
	if get_node("../Player/AnimatedSprite").flip_h:
		orientation = true
		$Sprite.flip_h = true
	else:
		orientation = false
		

func _physics_process(delta):
	if orientation:
		velocity.x = -speed
	else:
		velocity.x = speed
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	body.explode()
