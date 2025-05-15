extends Control

# Nodes
@onready var color_rect_countdown = $"ColorRect_Countdown"
@onready var color_rect_timer = $"ColorRect_Timer"
@onready var timer_label = $"ColorRect_Timer/Label"

# Timer variables
var countdown_values = ["3", "2", "1",]
var countdown_index = 0
var timer_value = 180  # 3 minutes (180 seconds)

func _ready() -> void:
	start_countdown()

# Start the countdown effect (3, 2, 1, START)
func start_countdown() -> void:
	countdown_index = 0
	color_rect_countdown.visible = true
	update_countdown_text()
	await get_tree().create_timer(1.0).timeout
	continue_countdown()

# Continue the countdown until "START"
func continue_countdown() -> void:
	countdown_index += 1

	if countdown_index < countdown_values.size():
		update_countdown_text()
		await get_tree().create_timer(1.0).timeout
		continue_countdown()
	else:
		color_rect_countdown.visible = false
		start_timer()

# Update the countdown text (3, 2, 1, START)
func update_countdown_text() -> void:
	color_rect_countdown.get_child(0).text = countdown_values[countdown_index]

# Start the main timer (3 minutes by default)
func start_timer() -> void:
	color_rect_timer.visible = true
	update_timer_text()
	await get_tree().create_timer(1.0).timeout
	_on_timer_tick()

# Update the timer text (MM:SS format)
func update_timer_text() -> void:
	var minutes = int(timer_value / 60)
	var seconds = int(timer_value % 60)
	timer_label.text = "%02d:%02d" % [minutes, seconds]

# Timer tick (counting down)
func _on_timer_tick() -> void:
	timer_value -= 1
	update_timer_text()

	if timer_value > 0:
		await get_tree().create_timer(1.0).timeout
		_on_timer_tick()
	else:
		_on_timer_end()

# Timer end (loads next scene)
func _on_timer_end() -> void:
	get_tree().change_scene("res://YourNextScene.tscn")
