extends Node
#control for after the emit happens from the floor 
@onready var the_guy: Node3D = $"../the guy"
@onready var guy_animation: AnimationPlayer = $"../the guy/Guy_animation"
signal text_start
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_falling_room_start_episode_0() -> void:
	guy_animation.play("Guy animation")
	await guy_animation.animation_finished
	text_start.emit()
	
