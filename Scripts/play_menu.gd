extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/mainMenu.tscn")

func _on_сите_категории_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Сите-Категории.tscn")

func _on_english_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/english_categorie.tscn")

func _on_предмети_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Предмети.tscn")

func _on_животни_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Животни.tscn")

func _on_професии_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Професии.tscn")

func _on_луѓе_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Луѓе.tscn")

func _on_храна_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Храна.tscn")


func _on_активности_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Активности.tscn")

func _on_држави_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Држави.tscn")

func _on_спорт_pressed() -> void:
	get_tree().change_scene_to_file("res://Main Menues/Categories/Спорт.tscn")
