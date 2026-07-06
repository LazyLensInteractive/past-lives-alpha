extends Node3D
@onready var camlock = $"XROrigin3D/XRCamera3D/CamTextLock"
@onready var orb: Node3D = $"../orb"
@onready var world_control: MeshInstance3D = $"XROrigin3D/XRCamera3D/world control"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_control.visible = false
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully!")
		get_viewport().use_xr = true
	else:
		print("OpenXR failed to initialize. Please check your headset connection.")
	
	
	#text shit
	datamanger.player_text_lock.connect(_on_text_lock)
	datamanger.player_text_lock.emit(camlock)
	orb.change_memory("res://scenes/memory scenes/beach.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#why did i make this backwards? no idea.....
	if datamanger.stencil_state == true:
		world_control.visible = true
	if datamanger.stencil_state == false:
		world_control.visible = false
	#if Input.is_action_just_pressed("ui_focus_next"):
		#TextSystem.text_change("test")
	#if Input.is_action_just_pressed("ui_accept"):
		#TextSystem.step_text()

func _on_text_lock(lock_node: Marker3D):
	TextSystem.text_lock_location = lock_node
	print(lock_node, TextSystem.text_lock_location)
