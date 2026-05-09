extends MeshInstance3D
@onready var ray_cast_3d: RayCast3D = $"../RayCast3D"
var list 
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickable_object_action_pressed(pickable: Variant) -> void:
	if ray_cast_3d.is_colliding():
		var hit = ray_cast_3d.get_collider()
		hit.queue_free()
		hit.remove_from_group("Shootable")
		animation_player.play("gun fire")
