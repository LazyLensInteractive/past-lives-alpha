extends Node3D
class_name TextScript
#put the tscn into a scene choose the diolouge kee and make a marker for the npc marker for the player should already exist and audio for variation between 'voices'
@export var dialogue_key: String 
@export var auto_start: bool = true
@export var npc_head_marker: Marker3D
@export var slide_speed: float = 5.0
@export var look_threshold: float = 0.7
@export var typing_audio: AudioStreamPlayer3D
@export var auto_type = true
var xr_camera: XRCamera3D
@onready var text_mesh: MeshInstance3D = $MeshInstance3D


func _ready() -> void:
	TextSystem.text_data_commands.connect(text_data)
	TextSystem.done_talking.connect(line_done)
	xr_camera = get_viewport().get_camera_3d()
	if xr_camera == null:
		print("No Camera Found")
	if auto_start == true:
		start_talking()
	var text_mat = text_mesh.get_active_material(0)
	var viewport = $TextViewport
	text_mat.albedo_texture = viewport.get_texture()
	
func _process(delta: float) -> void:
	var camera_edge_marker = TextSystem.text_lock_location
	var direction_to_npc = xr_camera.global_position.direction_to(npc_head_marker.global_position)
	var camera_forward = -xr_camera.global_transform.basis.z
	var look_amount = camera_forward.dot(direction_to_npc)
	var goal_position: Vector3
	if look_amount > look_threshold:
		goal_position = npc_head_marker.global_position
		text_mesh.scale = Vector3(1, 1, 1)
	else:
		if camera_edge_marker == null:
			print("camera edge null... retrying data issue may exist")
			return
		goal_position = camera_edge_marker.global_position
		text_mesh.scale = Vector3(0.2, 0.2, 0.2)
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
	print("talking now")
	TextSystem.current_text = self
	TextSystem.text_change(dialogue_key)

func _on_auto_text_timeout() -> void:
	print("timeout")
	if TextSystem.is_typing:
		return
	if TextSystem.current_text == self:
		TextSystem.step_text()
func text_data(command: String):
	print(command)
	if command == "#>#":
		TextSystem.step_text()
func line_done():
	if auto_type == true:
		TextSystem.step_text()
	else:
		print("wrong")


func _on_control_for_after_fall_game_start_text_start() -> void:
	start_talking()
func talk(sentence: String, min_speed: float, max_speed: float, bubble_color: Color):
	# bbcode stuffs
	# colors and formatting
	sentence = sentence.replace("b^", "[b]")
	sentence = sentence.replace("/b", "[/b]")
	sentence = sentence.replace("i^", "[i]")
	sentence = sentence.replace("/i", "[/i]")
	sentence = sentence.replace("red^", "[color=#ff0000]")
	sentence = sentence.replace("/red", "[/color]")
	sentence = sentence.replace("grn^", "[color=#00ff00]")
	sentence = sentence.replace("/grn", "[/color]")
	sentence = sentence.replace("ylw^", "[color=#ffff00]")
	sentence = sentence.replace("/ylw", "[/color]")
	# effects
	sentence = sentence.replace("w^", "[wave freq=5.0 amp=25.0]")
	sentence = sentence.replace("/w", "[/wave]")
	sentence = sentence.replace("t^", "[tornado radius=3.0 freq=5.0]")
	sentence = sentence.replace("/t", "[/tornado]")
	sentence = sentence.replace("f^", "[fade start=1 length=10]")
	sentence = sentence.replace("/f", "[/f]")
	sentence = sentence.replace("r^", "[rainbow freq=0.5 sat=1.0 val=1.0]")
	sentence = sentence.replace("/r", "[/rainbow]")
	sentence = sentence.replace("s^", "[shake]")
	sentence = sentence.replace("/s", "[/shake]")
	
	var label = $TextViewport/RichTextLabel
	var text_mesh = $MeshInstance3D
	if not is_instance_valid(label):
		return
