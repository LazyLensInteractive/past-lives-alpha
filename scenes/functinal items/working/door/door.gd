extends Node3D
@onready var animation: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_door_open_body_entered(body: Node3D) -> void:
	if body is XRToolsPlayerBody:
		animation.play("door open")
	else:
		print(body)


func _on_change_visibility_body_entered(body: Node3D) -> void:
	if body is XRToolsPlayerBody:
		datamanger.stencil_state = true

func _on_change_visibility_body_exited(body: Node3D) -> void:
	if body is XRToolsPlayerBody:
		datamanger.stencil_state = false
