extends StaticBody

onready var mesh_instance: MeshInstance = $MeshInstance
export (Resource) var folder
var enabled = false
var nav_mesh

func _ready() -> void:
	nav_mesh = get_tree().get_nodes_in_group("navigation_mesh_instance")[0]
	#mesh_instance.material/0 = 
	#print(nav_mesh)

func on_interaction(value):
	enabled = value
	
	if enabled:
		translation.y = -2
		nav_mesh.update_mesh()
		print("door opened")
	if not enabled:
		translation.y = 3
		nav_mesh.update_mesh()
		print("door closed")
