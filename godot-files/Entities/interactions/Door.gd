extends StaticBody


var enabled = false
var nav_mesh


func _ready() -> void:
	nav_mesh = get_tree().get_nodes_in_group("navigation_mesh_instance")[0]
	print(nav_mesh)

func on_interaction(value):
	enabled = value
	
	if enabled:
		translation.y = -2
		nav_mesh.bake_navigation_mesh(false)
		nav_mesh.setup_nav_server()
		print("door opened")
		#yield(get_tree(), "physics_frame")
	if not enabled:
		translation.y = 3
		nav_mesh.bake_navigation_mesh(false)
		nav_mesh.setup_nav_server()
		#yield(get_tree(), "physics_frame")
		print("door closed")
