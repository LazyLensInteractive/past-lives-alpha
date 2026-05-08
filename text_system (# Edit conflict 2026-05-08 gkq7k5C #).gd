extends Node3D
var text_location = null
var current_text: Node3D
var text_data = []
func _ready() -> void:
	var text_file_load = FileAccess.get_file_as_string("res://the text file.json")
	text_data = JSON.parse_string(text_file_load)
	if text_data == null:
		print("fucked up lil bro")
	else:
		print("working lil bro")
func text_change(option: String):
	if current_text == null:
		print("place to put the text returned null")
	if not text_data.has(option):
		print("json entry not found for",  " ", option, " ", "check spelling?")
		return
	current_text.global_position = text_location.global_position
	current_text.get_node("Label3D").text = text_data[option]["text"]
