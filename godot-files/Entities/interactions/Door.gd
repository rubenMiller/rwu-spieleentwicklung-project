extends MeshInstance


var enabled = false
var nav_mesh


func _ready() -> void:
	nav_mesh = get_tree().get_nodes_in_group("navigation_mesh_instance")[0]
	print(nav_mesh)

func on_interaction(value):
	enabled = value
	
	if enabled:
		translation.y = -1
		nav_mesh.bake_navigation_mesh(false)
	if not enabled:
		translation.y = 3
		nav_mesh.bake_navigation_mesh(false)
