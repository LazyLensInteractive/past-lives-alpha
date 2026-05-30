extends Node
var current_discs



func _ready() -> void:
	current_discs = get_tree().get_nodes_in_group("Discs")



func _process(delta: float) -> void:
	pass
