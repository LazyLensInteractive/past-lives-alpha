extends Node3D
@export var text_location: Marker3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TextSystem.current_text = self
	TextSystem.text_location = text_location


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
