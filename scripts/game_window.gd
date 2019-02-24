extends Node2D

var words_library
var current_word
var secret_word

# Called when the node enters the scene tree for the first time.
func _ready():
	init_edit_fields()
	words_library = get_words_collection("./data/words_spanish.json")	
	current_word = get_random_word(words_library)	
	secret_word = encryp_word(current_word)	
	update_secret_word_field(secret_word)
	pass

# Init scene fileds
func init_edit_fields():
	$board/word_label.clear()
	$board/chars_used.clear()
	$board/char_input.clear()
	$board/word_input.clear()

# Return a JSON object from JSONfilePath
func get_words_collection(JSONfilePath):
	var file = File.new()
	var result = file.open(JSONfilePath, File.READ)
	if result != 0:
		print("ERROR openein: "+JSONfilePath)
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

# Basic game loop structure
func game_loop():
	pass

# Signal: char_input ENTERED behavior
func _on_char_input_text_entered(new_text):
	game_loop()
	pass
