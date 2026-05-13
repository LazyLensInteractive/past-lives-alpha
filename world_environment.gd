extends WorldEnvironment


var tween_start = false

func _process(delta: float) -> void:
	if datamanger.player_dead and not tween_start:
		start_the_fog()

func start_the_fog():
	tween_start = true
	var tween = create_tween()
	tween.tween_property(environment, "fog_density", 2.0, 10.0)
	print("Fog transition started!")
