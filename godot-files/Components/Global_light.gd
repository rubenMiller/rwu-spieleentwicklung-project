extends Position3D

export var is_time_changing := true
export var rotation_speed := 1.0

func _physics_process(delta: float) -> void:
	if is_time_changing:
		rotation.z += rotation_speed / 1000
