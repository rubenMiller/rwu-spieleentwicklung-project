extends Area

export var radius := 5.0

onready var collision_shape: CollisionShape = $CollisionShape
onready var mesh_instance: MeshInstance = $MeshInstance

func _ready() -> void:
	mesh_instance.mesh.top_radius = radius
	mesh_instance.mesh.bottom_radius = radius
	mesh_instance.global_translation.y = 1
	
	collision_shape.shape.radius = radius
	
