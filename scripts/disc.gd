extends Node3D
@export var disc_id = 0
@onready var cassete_control: AnimationPlayer = $"../Table (after fall menu)/portable_cassette_player_1k/StaticBody3D/cassete body/cassete lid/cassete control"
@onready var pickable_object: XRToolsPickable = $PickableObject
@onready var marker_3d: Marker3D = $"../Table (after fall menu)/portable_cassette_player_1k/Marker3D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(pickable_object.global_position)


func _on_area_3d_cassette_in() -> void:
	print("yeah")
	pickable_object.freeze = true
	pickable_object.drop()
	#var tween = create_tween()
	#tween.tween_property(self, "global_position", marker_3d.global_position, 1.3)
	cassete_control.play("lock cartridge")
