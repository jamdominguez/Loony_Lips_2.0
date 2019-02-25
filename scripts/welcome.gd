extends Node2D

var strings

# Called when the node enters the scene tree for the first time.
func _ready():
	strings = get_json("res://data/strings_english.json")
	$welcome_board/welcome_label.text = strings.welcome_title
	$welcome_board/start_button.text = strings.welcome_button

# Return a JSON object from JSONfilePath
func get_json(JSONfilePath):
	var file = File.new()
	var result = file.open(JSONfilePath, File.READ)
	if result != 0:
		print("ERROR opening: "+JSONfilePath)
	var text = file.get_as_text()#[{"word":"car"},{"word":"dog"}...]	
	file.close()	
	return parse_json(text)

# Signal: button pressed behavior
func _on_start_button_pressed():
	print("pressed")	
	print(get_tree().change_scene("res://scenes/game_window.tscn"))