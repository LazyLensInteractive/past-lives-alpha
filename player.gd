extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully!")
		get_viewport().use_xr = true
	else:
		print("OpenXR failed to initialize. Please check your headset connection.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_focus_next"):
		TextSystem.text_change("test")
	if Input.is_action_just_pressed("ui_accept"):
		TextSystem.step_text()
