extends Area

export var radius := 5.0
export var rotation_speed := 1.0

onready var collision_shape: CollisionShape = $CollisionShape
onready var mesh_instance: MeshInstance = $MeshInstance2

func _ready() -> void:
	#mesh_instance.mesh.top_radius = radius
	#mesh_instance.mesh.bottom_radius = radius
	mesh_instance.scale.x *= radius
	mesh_instance.scale.z *= radius
	mesh_instance.global_translation.y = 1
	
	collision_shape.shape.radius = radius
	
func _physics_process(delta: float) -> void:
	mesh_instance.rotation.y += rotation_speed / 100
