extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_language_button_item_selected(0)
	$welcome_board/language_button.add_item('Espanol', 0)
	$welcome_board/language_button.add_item('English', 1)

func refresh_labels():
	$welcome_board/welcome_label.text = global.strings.welcome_title
	$welcome_board/start_button.text = global.strings.welcome_button
	$welcome_board/language_label.text = global.strings.select_language_label

###########################################################################
###########################################################################
###########################################################################
# Signal: button pressed behavior
func _on_start_button_pressed():
	var scene_path = "res://scenes/game_window.tscn"
	var result = get_tree().change_scene(scene_path)
	if result != 0:
		print("ERROR opening scene: " + scene_path)

# Signal: language button pressed behavior
func _on_language_button_item_selected(ID):	
	if ID == 0:
		global.strings = global.get_json("res://data/strings_spanish.json")
		global.words_library = global.get_json("res://data/words_spanish.json")
	elif ID == 1:
		global.strings = global.get_json("res://data/strings_english.json")
		global.words_library = global.get_json("res://data/words_english.json")
	refresh_labels()