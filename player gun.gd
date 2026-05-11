extends MeshInstance3D
@onready var ray_cast_3d: RayCast3D = $"../RayCast3D"
var list 
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var audio_stream_player_3d: AudioStreamPlayer3D
var ammo = 10
@onready var shoot_delay: Timer = $"../shoot delay"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickable_object_action_pressed(pickable: Variant) -> void:
	if not shoot_delay.is_stopped():
		print("shoot delay working")
		return

	if not ammo == 0:
		if ray_cast_3d.is_colliding():
			var hit = ray_cast_3d.get_collider()
			hit.queue_free()
			hit.remove_from_group("Shootable")
			shoot_delay.start()
			ammo -= 1
			animation_player.play("gun fire")
			audio_stream_player_3d.play(1)
	else:
		print("no more ammo")
