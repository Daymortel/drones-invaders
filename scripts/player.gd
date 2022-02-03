extends KinematicBody2D

var velocity = Vector2(0,0)
const speed = 100
const gravity = 35
const jumpforce = -1100

signal hit

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("click"):
		$AnimatedSprite.play("shoot")
	else:
		$AnimatedSprite.play("default")
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = jumpforce * 0.7

	velocity.y = velocity.y + gravity
	
	velocity = move_and_slide(velocity,Vector2.UP)
	
	velocity.x = lerp(velocity.x,0,0.2)

func _on_triger_body_entered(body):
	emit_signal("hit")
	body.explode()
