extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$welcome_board/welcome_label.text = "Loony Lips 2.0"
	$welcome_board/start_button.text = "START"

# Signal: button pressed behavior
func _on_start_button_pressed():
	print("pressed")	
	get_tree().change_scene("res://scenes/game_window.tscn")