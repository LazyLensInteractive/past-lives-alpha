extends Node3D
@onready var view: SubViewport = $SubViewport



func change_memory(scene_path: String):
	var memory = load(scene_path)
	var live_memory = memory.instantiate()
	view.add_child(live_memory)
