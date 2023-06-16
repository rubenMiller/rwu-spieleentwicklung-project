extends Area

export var radius := 5.0

export (Resource) var mesh_instance 
onready var mesh: MeshInstance = $radius_mesh_instance
onready var collision_shape = $CollisionShape

func _ready() -> void:
	if mesh_instance != null:
		mesh.mesh = mesh_instance
		
	mesh.global_translation.y = 2
	mesh.scale.x = radius
	mesh.scale.z = radius
	
	collision_shape.global_translation.y = 2.1
	collision_shape.scale.x = radius
	collision_shape.scale.z = radius
	
	collision_shape.shape = mesh.mesh.create_convex_shape()
	
