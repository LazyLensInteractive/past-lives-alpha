extends Area3D

func _on_body_entered(body: Node3D) -> void:
	print("enter")
	var disc_parrent = body.get_parent()
	if disc_parrent.is_in_group("Discs"):
		print(disc_parrent.disc_id)
	else:
		print(body)
