extends Area

export var radius := 5.0

export (Resource) var mesh_instance 
onready var mesh: MeshInstance = $radius_mesh_instance
onready var collision_shape = $CollisionShape

func _ready() -> void:
	#mesh.mesh = mesh_instance
	mesh.global_translation.y = 2
	collision_shape.global_translation.y = 2
	#collision_shape.shape = mesh.create_convex_collision()
	
