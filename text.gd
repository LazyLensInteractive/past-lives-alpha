extends Node3D

@export var dialogue_key: String = "war_guy" 
@export var auto_start: bool = true
@export var npc_head_marker: Marker3D
@export var camera_edge_marker: Marker3D
@export var slide_speed: float = 5.0
@export var look_threshold: float = 0.7
@export var typing_audio: AudioStreamPlayer3D
var xr_camera: XRCamera3D
@onready var label_3d: Label3D = $Label3D 

func _ready() -> void:
	xr_camera = get_viewport().get_camera_3d()
	if xr_camera == null:
		print("No Camera Found")
	if auto_start == true:
		start_talking()

func _process(delta: float) -> void:
	if not npc_head_marker or not camera_edge_marker or not xr_camera:
		return 
	var direction_to_npc = xr_camera.global_position.direction_to(npc_head_marker.global_position)
	var camera_forward = -xr_camera.global_transform.basis.z
	var look_amount = camera_forward.dot(direction_to_npc)
	var goal_position: Vector3
	if look_amount > look_threshold:
		goal_position = npc_head_marker.global_position
		label_3d.pixel_size = 0.005
	else:
		goal_position = camera_edge_marker.global_position
		label_3d.pixel_size = 0.001
	global_position = global_position.lerp(goal_position, slide_speed * delta)
	look_at(xr_camera.global_position, Vector3.UP)
	rotate_object_local(Vector3.UP, PI)
	if typing_audio == null:
		return
	elif TextSystem.is_typing == true:
		if not typing_audio.playing:
			typing_audio.play()
	else:
		typing_audio.stop()

func start_talking() -> void:
	print("call")
	TextSystem.current_text = self
	TextSystem.text_change(dialogue_key)

func _on_auto_text_timeout() -> void:
	print("timeout")
	if TextSystem.is_typing:
		return
	if TextSystem.current_text == self:
		TextSystem.step_text()
