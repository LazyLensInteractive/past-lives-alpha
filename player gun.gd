extends MeshInstance3D
@onready var ray_cast_3d: RayCast3D = $"../RayCast3D"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@export var audio_stream_player_3d: AudioStreamPlayer3D
@onready var shoot_delay: Timer = $"../shoot delay"
@onready var death: Timer = $"../death"
var ammo = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pickable_object_action_pressed(pickable: Variant) -> void:
	if not shoot_delay.is_stopped():
		return

	if not ammo == 0:
		if ray_cast_3d.is_colliding():
			var hit = ray_cast_3d.get_collider()
			hit.remove_from_group("Shootable")
			hit.queue_free()
			shoot_delay.start()
			ammo -= 1
			animation_player.play("gun fire")
			audio_stream_player_3d.play(1)
	else:
		audio_stream_player_3d.set_stream(load("res://audio/freesound_community-empty-gun-shot-6209.mp3"))
		audio_stream_player_3d.play()
		death.start()


func _on_death_timeout() -> void:
	TextSystem.text_change("test2")
	TextSystem.step_text()
	print("Death timer finished, requesting text change to test2")
