extends Area3D
@onready var stars: GPUParticles3D = $"../../GPUParticles3D"
@onready var main: AnimationPlayer = $"../../Main"
@export var dummy_cassette: MeshInstance3D 
signal cassette_in
var is_tape_inside = false

func _ready() -> void:
	if dummy_cassette:
		dummy_cassette.visible = false

func _on_body_entered(body: Node3D) -> void:
	print(body)
	var disc_parent = body.get_parent()
	if "disc_id" in disc_parent:
		monitoring = false
		datamanger.current_disc = disc_parent.disc_id
		if dummy_cassette:
			dummy_cassette.visible = true
		is_tape_inside = true
		cassette_in.emit()
func start_game_sequence() -> void:
	var disc = datamanger.current_disc
	if disc == 1:
		var tween = create_tween()
		tween.tween_property(stars, "amount_ratio", 0, 30)
		main.play("play_game")
func _on_lid_detect_body_entered(body: Node3D) -> void:
	if is_tape_inside:
		if not body.is_in_group("cassetee lid"):
			print(body)
			return
		start_game_sequence() 
	else:
		print("tape not inside but lid shut")
