extends Control

func _ready():
	load_highscore()

func _on_Play_pressed():
	get_tree().change_scene("res://scenes/game.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")

#Cette fonction charge les meilleurs temps
#Sous GNU/Linux le fichier se situe dans /home/$USER/.local/share/godot/app_userdata/Drones Invaders/
func load_highscore():
	var save_file = File.new()
	if not save_file.file_exists("user://highscore.json"):
		return #Ne fait rien si le fichier n'existe pas

	save_file.open("user://highscore.json", File.READ) #Ouvre le fichier
	var json_str = save_file.get_as_text()
	var game_data = JSON.parse(json_str).result
	Global.highscore = game_data.highscore #Met la première ligne du fichier dans une variable "highscore"
	$HighScoreContainer/HighScoreValue.text = String(Global.highscore) #Change le texte
	save_file.close() #Ferme le fichier
