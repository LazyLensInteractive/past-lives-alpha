extends Node
var current_data = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextSystem.text_data_commands.connect(collect_data)



func collect_data(data:String):
	print("worked")
	current_data = data
	if data == "test2":
		pass #later work
