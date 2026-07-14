extends Node3D
@export var JSON_KEY: String
@export var Charecter_NODE: Node3D



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is XRToolsPlayerBody:
		var TEXT_NODE = Charecter_NODE.find_child("text (setup)")
		print("valid body")
		TEXT_NODE.dialogue_key = JSON_KEY
		print("set key")
		TEXT_NODE.start_talking()
		print("started talking")


func _on_area_3d_area_entered(area: Area3D) -> void:
	pass # Replace with function body.
