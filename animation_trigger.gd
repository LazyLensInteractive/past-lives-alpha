extends Node3D
@export var set_animation: AnimationPlayer
@export var animation_Name: String
@export var play_delay: float
@export var trigger_count: int = 1
var trigger_amount = 0



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is XRToolsPlayerBody:
		if trigger_count > trigger_amount:
			trigger_amount += 1
			set_animation.play(animation_Name)
		else: 
			print("no triggers left")



func _on_area_3d_area_entered(area: Area3D) -> void:
	pass
