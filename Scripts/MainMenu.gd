extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_red_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/play_menu.tscn")


func _on_pink_button_h2p_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/how_to_play.tscn")


func _on_green_button_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/settings.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
