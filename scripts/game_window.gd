extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# init_edit_fields()
	# words_library = get_words_collection(JSONfilepath)
	# current_word = get_random_word(words_library)
	# secret_word = encryp_word(current_word)
	# update_secret_word_field(secret_word)
	pass

# Basic game loop structure
func game_loop():
	pass


# Signal: char_input ENTERED behavior
func _on_char_input_text_entered(new_text):
	game_loop()
	pass
