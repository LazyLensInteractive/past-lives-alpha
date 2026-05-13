extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func scene_switch():
	if datamanger.player_dead == true and TextSystem.is_typing == false:
		get_tree().call_group("xr_tools_pickup_functions", "drop_object")
		get_tree().change_scene_to_file.call_deferred("res://scenes/house.tscn")
