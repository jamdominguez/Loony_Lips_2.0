extends Node

var strings
var words_library

func _ready():
	pass # Replace with function body.

# Return a JSON object from JSONfilePath
func get_json(JSONfilePath):
	var file = File.new()
	var result = file.open(JSONfilePath, File.READ)
	if result != 0:
		print("ERROR opening: "+JSONfilePath)
	var text = file.get_as_text()
	file.close()
	return parse_json(text)