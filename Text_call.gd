extends Node
#this objects only purpous is to check which text file needs to be loaded 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextSystem.text_load("res://Text files/the text file.json")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
