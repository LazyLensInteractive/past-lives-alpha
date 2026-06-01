extends WorldEnvironment


var tween_start = true

func _process(delta: float) -> void:
	start_the_fog()
	if datamanger.player_dead and not tween_start:
		return

func start_the_fog():
	tween_start = true
	var tween = create_tween()
	tween.tween_property(environment, "fog_density", 2.0, 10.0)
	
