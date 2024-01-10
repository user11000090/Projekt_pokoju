extends Control

func _ready():
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().quit()
func _on_button_pressed():
	get_tree().change_scene_to_file("res://dzien.tscn")
func _on_wieczor_pressed():
	get_tree().change_scene_to_file("res://pokoj_wieczor.tscn")
