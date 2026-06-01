extends RigidBody3D
var list
@onready var ray_cast_3d: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	list = get_tree().get_nodes_in_group("Shootable")
	shooting_loop()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func shoot(target_num: int):
		list = get_tree().get_nodes_in_group("Shootable")
		await get_tree().process_frame
		if target_num >= list.size():
			
			return
		var shoot_at = list[target_num]
		if not is_instance_valid(shoot_at):
			
			return
		look_at(shoot_at.global_position)
		if ray_cast_3d.is_colliding():
			shoot_at.queue_free()
			list = get_tree().get_nodes_in_group("Shootable")
			await get_tree().process_frame

func shooting_loop():
	var id_max = list.size()
	
	while true:
		list = get_tree().get_nodes_in_group("Shootable")
		var picked = randi_range(0, id_max - 1)
		
		await get_tree().create_timer(12).timeout
	
		shoot(picked)
		
		
