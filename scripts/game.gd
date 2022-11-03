extends Node2D

const bullet_ressource = preload("res://scenes/fire.tscn")
export(PackedScene) var mob_scene
export(PackedScene) var gregoire_scene
var mob = null

var life = 5
var score = 0
var score_to_next_level = 1000

func _physics_process(delta):
	if Input.is_action_just_pressed("click") and life > 0:
		var bullet = bullet_ressource.instance()
		add_child(bullet)

func _on_MobSpawnTimer_timeout():
	randomize()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation");
	mob_spawn_location.offset = randi()
	
	if Global.gregoire:
		mob = gregoire_scene.instance()
	else:
		mob = mob_scene.instance()
		
	# Create a Mob instance and add it to the scene.
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

func _on_Player_hit():
	var bar_id = get_node("HUD/LifeBar" + str(life))
	bar_id.queue_free()
	life -= 1
	
	if life == 0:
		$Player.queue_free()
		$HUD/GameOver.show()
		$GameOverTimer.start()
		
		if score > Global.highscore:
			save_highscore() #Sauvegarde le record
			SilentWolf.Scores.persist_score(Global.player_name, score) #Inscrit votre record dans les classements

func _on_GameOverTimer_timeout():
	get_tree().change_scene("res://scenes/menu.tscn")

func add_score(points):
	score += points
	$HUD/ScoreValue.text = str(score)

func _on_AddScoreTimer_timeout():
	if life > 0:
		add_score(10)
	if score >= score_to_next_level:
		$MobSpawnTimer.wait_time /= 2
		score_to_next_level += score_to_next_level

# Sauvegarde le meilleur score
func save_highscore():
	var data = {
		"highscore" : score
	}
	
	var save_file = File.new()
	save_file.open("user://highscore.json", File.WRITE)
	save_file.store_line(to_json(data))
	save_file.close()
