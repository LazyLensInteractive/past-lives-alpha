extends Node3D
var text_location = null
var current_text: Node3D
var text_data = {}
var current_line = 0
var current_option = ""
var is_typing = false
var typing_id = 0


@export_file("*.json") var current_loaded_text: String = ""
func text_load(Path: String):
	Path = FileAccess.get_file_as_string(Path)
	if Path == null:
		return
	text_data = JSON.parse_string(Path)
	print("Keys found in JSON: ", text_data.keys())
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
	
func _ready() -> void:
	pass
	
func text_display():
	typing_id += 1
	var local_id = typing_id
	is_typing = true
	var sentance = text_data[current_option]["lines"][current_line]
	var label = current_text.get_node("Label3D")
	label.text = ""
	if not is_instance_valid(label):
		return
	for letter in sentance:
		if local_id != typing_id or not is_instance_valid(label):
			return
		label.text += letter
		var typing_variation = randf_range(0.01, 0.2)
		await get_tree().create_timer(typing_variation).timeout
	is_typing = false
func step_text():
	if current_option == "":
		return 
	var amount_lines = text_data[current_option]["lines"] as Array
	if current_line + 1 < amount_lines.size():
		current_line += 1
		text_display()
	else:
		current_text.get_node("Label3D").text = ""
		current_option = ""
