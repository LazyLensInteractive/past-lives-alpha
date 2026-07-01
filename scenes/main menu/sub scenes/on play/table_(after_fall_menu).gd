extends Node3D
@export var mesh_node: MeshInstance3D
var unique_mat: BaseMaterial3D
func _ready() -> void:
	if not mesh_node:
		mesh_node = find_child("*", true, false) as MeshInstance3D
	if mesh_node:
		var current_mat = mesh_node.get_active_material(0)
		if current_mat:
			unique_mat = current_mat.duplicate()
			mesh_node.material_override = unique_mat
	if datamanger:
		datamanger.stencil_state_changed.connect(_on_stencil_broadcast)
		_on_stencil_broadcast(datamanger.stencil_state)
func _on_stencil_broadcast(new_state: bool) -> void:
	if unique_mat:
		if new_state == true:
			unique_mat.stencil_flags &= ~BaseMaterial3D.STENCIL_FLAG_READ
		else:
			unique_mat.stencil_flags |= BaseMaterial3D.STENCIL_FLAG_READ
