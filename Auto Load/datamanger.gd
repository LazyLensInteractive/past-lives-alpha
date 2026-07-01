extends Node
var player_dead = false
var current_disc = null

signal player_text_lock(lock_node: Marker3D)
signal stencil_state_changed(new_state: bool)

var stencil_state: bool = false:
	set(value):
		stencil_state = value
		stencil_state_changed.emit(stencil_state)
