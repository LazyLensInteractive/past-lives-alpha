extends Node3D
var text_location = null
var current_text: Node3D
var text_data = {}
var current_line = 0
var current_option = ""
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
		return
	if not text_data.has(option):
		print("json entry not found for", option, "check spelling?")
		return
	current_option = option
	current_line = 0
	text_display()
	#current_text.global_position = text_location.global_position
	#current_text.get_node("Label3D").text = text_data
func text_display():
	var sentance = text_data[current_option]["lines"][current_line]
	var label = current_text.get_node("Label3D")
	label.text = ""
	for letter in sentance:
		label.text += letter
		var typing_variation = randf_range(0.01, 0.2)
		await get_tree().create_timer(typing_variation).timeout
		
func step_text():
	var amount_lines = text_data[current_option]["lines"]
	if current_line + 1 < amount_lines.size():
		current_line += 1
		text_display()
	else:
		current_text.get_node("Label3D").text = ""
		current_option = ""
