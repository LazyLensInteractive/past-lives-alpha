extends Area3D

@onready var stars: GPUParticles3D = $"../../GPUParticles3D"
@onready var main: AnimationPlayer = $"../../Main"
signal cassette_in
func _on_body_entered(body: Node3D) -> void:
	
	print("enter")
	var disc_parrent = body.get_parent()
	if "disc_id" in disc_parrent:
		monitoring = false
		cassette_in.emit()
		print(disc_parrent.disc_id)
		datamanger.current_disc = disc_parrent.disc_id
		#print(datamanger.current_disc)
		#var disc = datamanger.current_disc
		#menu_upadte(disc)
	else:
		print(body)


func menu_upadte(disc: int):
	print(disc, " menu update")
	

func _on_cassete_control_animation_finished(_anim_name: StringName) -> void:
	var disc = datamanger.current_disc
	if disc == 1:
		var tween = create_tween()
		tween.tween_property(stars, "amount_ratio", 0, 30)
		main.play("play_game")
		
