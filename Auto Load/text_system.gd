extends Node3D
var text_location = null
var current_text: Node3D
var text_lock_location: Marker3D
var text_data = {}
var current_line = 0
var current_option = ""
var is_typing = false
var typing_id = 0
var min_type_speed: float
var max_type_speed: float
signal done_talking #only use this for timing and when you can change scenes

@export_file("*.json") var current_loaded_text: String = ""
func text_load(Path: String):
	Path = FileAccess.get_file_as_string(Path)
	if Path == null:
		print("path for json is not valid")
		return
	text_data = JSON.parse_string(Path)
	print("data found in json of these types ", text_data.keys())
	if text_data == null:
		print("json file was not able to load")
	else:
		print("json has loaded")
func text_change(option: String):
	if current_text == null:
		print("place to put the text returned null")
		return
	if not text_data.has(option):
		print("json entry not found for ", option, " check spelling?")
		return
	current_option = option
	current_line = 0
	text_display()
	
func _ready() -> void:
	pass
	
func text_display():
	min_type_speed = text_data[current_option]["speed_min"]
	max_type_speed = text_data[current_option]["speed_max"]
	typing_id += 1
	var local_id = typing_id
	is_typing = true
	var sentence = text_data[current_option]["lines"][current_line]
	
	# bbcode stuffs
	# colors and formatting
	sentence = sentence.replace("b^", "[b]")
	sentence = sentence.replace("/b", "[/b]")
	sentence = sentence.replace("i^", "[i]")
	sentence = sentence.replace("/i", "[/i]")
	sentence = sentence.replace("red^", "[color=#ff0000]")
	sentence = sentence.replace("/red", "[/color]")
	sentence = sentence.replace("grn^", "[color=#00ff00]")
	sentence = sentence.replace("/grn", "[/color]")
	sentence = sentence.replace("ylw^", "[color=#ffff00]")
	sentence = sentence.replace("/ylw", "[/color]")
	# effects
	sentence = sentence.replace("w^", "[wave freq=5.0 amp=25.0]")
	sentence = sentence.replace("/w", "[/wave]")
	sentence = sentence.replace("t^", "[tornado radius=3.0 freq=5.0]")
	sentence = sentence.replace("/t", "[/tornado]")
	sentence = sentence.replace("f^", "[fade start=1 length=10]")
	sentence = sentence.replace("/f", "[/f]")
	sentence = sentence.replace("r^", "[rainbow freq=0.5 sat=1.0 val=1.0]")
	sentence = sentence.replace("/r", "[/rainbow]")
	sentence = sentence.replace("s^", "[shake]")
	sentence = sentence.replace("/s", "[/shake]")
	
	var label = current_text.get_node("TextViewport/RichTextLabel")
	var text_mesh = current_text.get_node("MeshInstance3D")
	if not is_instance_valid(label):
		return
	text_mesh.get_surface_override_material(0).albedo_color = text_data[current_option]["color"]
	label.bbcode_enabled = true
	label.text = sentence
	label.visible_characters = 0
	var total_letters = label.get_total_character_count()
	for i in range(total_letters):
		if local_id != typing_id or not is_instance_valid(label):
			return
		label.visible_characters += 1
		var typing_variation = randf_range(min_type_speed, max_type_speed)
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
		current_text.get_node("TextViewport/RichTextLabel").text = ""
		current_option = ""
		done_talking.emit(typing_id)
