extends Control


func _on_FullScreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Back_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")

func _on_Gregoire_toggled(button_pressed):
	Global.gregoire = button_pressed
