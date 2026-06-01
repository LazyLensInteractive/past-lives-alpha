extends Area3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

func _on_body_entered(body: Node3D) -> void:
	print("enter")
	var disc_parrent = body.get_parent()
	if "disc_id" in disc_parrent:
		print(disc_parrent.disc_id)
		datamanger.current_disc = disc_parrent.disc_id
		print(datamanger.current_disc)
		var disc = datamanger.current_disc
		menu_upadte(disc)
	else:
		print(body)
		
		
		

	
		


func menu_upadte(disc: int):
	print(disc, " menu update")
	if disc == 1:
		mesh_instance_3d.visible = false
