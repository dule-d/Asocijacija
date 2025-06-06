extends Control

# UI Nodes
@onready var countdown_label = $"Counter Label"
@onready var timer_label = $"Timer Label"
@onready var main_word_label = $Words
@onready var color_rect_bb = $ColorRect_Timer


# Timer variables that are used inside the func

var countdown_values = ["3","2","1"]
var countdown_index = 0
@onready var timer_value = GlobalSettings.timer_value



# Right and Left zones for right or wrong
@onready var left_click_zone = $Left
@onready var right_click_zone = $Right




#Buttons 
@onready var correct_button = $Right
@onready var wrong_button = $Left


# Score tracking
var correct_guesses = 0
var incorrect_guesses = 0


# Screen devided for right or wrong answers
var is_selecting = false
var is_game_active = false


var catagories = {

	"Професии": [	"Доктор", "Сестра", "Ветеринар", "Фармацевт", "Учител", "Психолог", "Логопед", "Научник", "Менаџер", "Секретар", 
					"Банкар", "Сметководител", "Адвокат", "Полицаец", "Пожарникар", "Војник", "Архитект", "Електричар", "Водоинсталатер", "Молер",
	 				"Програмер", "Уметник", "Фотограф", "Музичар", "Писател", "Готвач", "Келнер", "Туристички водич", "Рецепционер", "Инспектор", 
					"Возач", "Пилот", "Механичар", "Доставувач", "Фармер", "Ловец", "Градинар", "Шумар", "Еколог", "Глумец",
	  				"Режисер", "Новинар", "Продавач", "Стјуардеса", "Морнар", "Рибар", "Биолог", "Физичар", "Фризер", "Спортист", 
					"Судија", "Лимар", "Преведувач", "Волонтер", "Јутјубер", "ТикТокер",
					],
}

var current_category = "Професии"

var word_list = []



func _ready():
	word_list = catagories[current_category].duplicate()
	hide_main_words()

	left_click_zone.connect("gui_input", Callable(self, "_on_left_zone_input"))
	right_click_zone.connect("gui_input", Callable(self, "_on_right_zone_input"))



# Countdown - 3,2,1
func hide_main_words():
	main_word_label.visible = false
	await start_countdown()
	main_word_label.visible = true

func start_countdown() -> void:
	countdown_label.visible = true
	timer_label.visible = false
	
	correct_button.disabled = true
	wrong_button.disabled = true

	while countdown_index < countdown_values.size():
		countdown_label.text = countdown_values[countdown_index]
		countdown_index += 1
		$CountDownTimer.play()
		await get_tree().create_timer(1.0).timeout


	correct_button.disabled = false
	wrong_button.disabled = false
		
	countdown_label.visible = false
	timer_label.visible = true
	
	is_game_active = true
	$Beep.play()
	start_main_timer()

func start_main_timer():
	var remaining_time = timer_value
	display_random_word(current_category)

	while remaining_time > 0:
		var minutes = int(remaining_time / 60)
		var seconds = int(remaining_time) % 60
		timer_label.text = "%02d:%02d" % [minutes, seconds]
		await get_tree().create_timer(1.0).timeout
		remaining_time -= 1
	
	timer_label.text = "00:00"
	end_game()

func display_random_word(category: String):
	if	word_list.is_empty():
		word_list = catagories[category].duplicate()
	var random_word = word_list.pick_random()
	main_word_label.text = random_word
	word_list.erase(random_word)

func change_word():
	display_random_word(current_category)
	await get_tree().create_timer(1.0).timeout
	color_rect_bb.color = Color8(255, 159, 0, 255)
	is_selecting = false

func end_game():
	main_word_label.text = "End!\nCorrect: %d\nIncorrect: %d" % [correct_guesses, incorrect_guesses]
	$Win.play()
	main_word_label.visible = true
	
	correct_button.disabled = true
	wrong_button.disabled = true




func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("Main Menues/play_menu.tscn")




func _on_correct_button_pressed() -> void:
	if not is_game_active or is_selecting:
		return
	is_selecting = true
	correct_guesses += 1
	color_rect_bb.color = Color(0, 1, 0)  # Green
	change_word()
	$Correct.play()

func _on_wrong_button_pressed() -> void:
	if not is_game_active or is_selecting:
		return
	is_selecting = true
	incorrect_guesses += 1
	color_rect_bb.color = Color(1, 0, 0)  # Red
	change_word()
	$Incorrect.play()
