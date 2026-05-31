extends Node
# here is where all random things are tied most being a child of the main fun_factor this is only ran once at startup and saved in the main save file (very inspired by undertale's version of this but there is way more things)
var fun_factor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fun_factor = randi_range(0, 100)
	print(fun_factor)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
