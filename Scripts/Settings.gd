extends Control

@onready var timer_input = $LineEdit
@onready var confirm_button = $Button

func _ready():
	confirm_button.pressed.connect(_on_confirm_pressed)

func _on_confirm_pressed():
	var input_value = timer_input.text.to_int()
	if input_value > 0:
		# Call a global singleton or emit a signal
		GlobalSettings.timer_value = input_value
		print("Timer set to: ", input_value)
	else:
		print("Invalid input")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/mainMenu.tscn")
