extends Node3D
@export var dialogue_key: String = "war_guy" 
@export var auto_start: bool = true
@onready var label_3d: Label3D = $Label3D 

func _ready() -> void:
	if auto_start:
		start_talking()
func start_talking() -> void:
	TextSystem.current_text = self
	TextSystem.text_change(dialogue_key)
func _on_auto_text_timeout() -> void:
	if TextSystem.is_typing:
		return
	if TextSystem.current_text == self:
		TextSystem.step_text()
