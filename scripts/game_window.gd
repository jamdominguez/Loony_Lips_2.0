# TODOs
# if player_has_won() -- Welcome scene
# if player_has_lost() -- Lost scene
# Show all chars found into the word (no only one)
# If type a wrong char by second or more time, no count the error and draw the char
# Solve button functionality
# Create a json file with the language strings and load it

extends Node2D

var words_library
var current_word
var secret_word
var wrong_chars
var fails
const MAX_FAILS = 10
const BOARD_TEXTURES = [
	preload("res://assets//blackboard_0.jpg"),
	preload("res://assets//blackboard_1.jpg"),
	preload("res://assets//blackboard_2.jpg"),
	preload("res://assets//blackboard_3.jpg"),
	preload("res://assets//blackboard_4.jpg"),
	preload("res://assets//blackboard_5.jpg"),
	preload("res://assets//blackboard_6.jpg"),
	preload("res://assets//blackboard_7.jpg"),
	preload("res://assets//blackboard_8.jpg"),
	preload("res://assets//blackboard_9.jpg"),
	preload("res://assets//blackboard_10.jpg")
]
const START_TEXTURE = preload("res://assets//blackboard.jpg")
const LOST_TEXTURE = preload("res://assets//blackboard_lost.jpg")


# Called when the node enters the scene tree for the first time.
func _ready():
	init_edit_fields()
	words_library = get_words_collection("./data/words_spanish.json")
	current_word = get_random_word(words_library)
	secret_word = encryp_word(current_word)
	update_secret_word_field(secret_word)	
	wrong_chars = ""
	fails = 0
	pass

# Init scene fileds
func init_edit_fields():
	$board/word_label.clear()
	$board/chars_used.clear()
	$board/char_input.clear()
	$board/word_input.clear()
	$board/solve_label.text = "Solve!"

# Return a JSON object from JSONfilePath
func get_words_collection(JSONfilePath):
	var file = File.new()
	var result = file.open(JSONfilePath, File.READ)
	if result != 0:
		print("ERROR opening: "+JSONfilePath)
	var text = file.get_as_text()#[{"word":"car"},{"word":"dog"}...]	
	file.close()	
	return parse_json(text)

# Return a random word from the dictionary collection words_library
func get_random_word(words_library):
	randomize()
	var rand = randi() % words_library.size()
	return words_library[rand].word

# Return current_word as "ecrypted" word
func encryp_word(current_word):
	var secret_word = ""
	for i in current_word.length():
		secret_word += "-"
	return secret_word

# Update secret_word field with secret_word
func update_secret_word_field(secret_word):
	$board/word_label.text = secret_word
	pass

# Update chars_used field with wrong_chars
func update_wrong_chars(wrong_chars):
	$board/chars_used.text = wrong_chars
	pass

# Basic game loop structure
func game_loop(char_entered):
	$board/char_input.clear()
	var char_upper = char_entered.to_upper()
	var char_index = current_word.find(char_upper)
	var exist = char_index != -1
	if exist:
		show_chars_in_word_label(char_upper, char_index)
		if player_has_won():
			print(get_tree().reload_current_scene())
	else:
		fails += 1
		show_wrong_char(char_upper)
		change_board_texture(fails)
		if player_has_lost():
			$board.texture = LOST_TEXTURE
			disable_inputs()
	pass

# Update the secret word and show it in the board
func show_chars_in_word_label(char_entered, char_index):	
	secret_word[char_index] = char_entered
	update_secret_word_field(secret_word)

# Increase the fails counter and update the field in board
func show_wrong_char(char_entered):
	wrong_chars += char_entered
	update_wrong_chars(wrong_chars)

# Change board texture according fail counter
func change_board_texture(fails):
	$board.texture = BOARD_TEXTURES[fails]

# Check if the player found the current word
func player_has_won():
	return secret_word == current_word

# Check if the player got the MAX_FAILS
func player_has_lost():
	return fails >= MAX_FAILS

# Desible all inputs
func disable_inputs():
	$board/char_input.queue_free()
	$board/word_input.queue_free()
	$board/solve_button.queue_free()
	$board/solve_label.queue_free()
	
###########################################################################
###########################################################################
###########################################################################
# Signal: char_input ENTERED behavior
func _on_char_input_text_entered(char_entered):
	game_loop(char_entered)
	pass