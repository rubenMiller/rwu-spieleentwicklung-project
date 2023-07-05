extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component
onready var view_component: Area = $View_component
onready var turret: MeshInstance = $turret

onready var isSelected = false

export var rotate_speed := 0.2
	
func _process(delta: float) -> void:
	if attack_component.current_target != null:
		rotate_tower(delta)
		
func rotate_tower(delta):
	var target = attack_component.current_target
	var v = target.global_translation - global_translation
	var target_rotation = atan2(v.x,v.z) 

	var relative_rotation = target_rotation - turret.global_rotation.y
	
	# ChatGPT <3
	if relative_rotation > PI:
		relative_rotation -= 2 * PI
	if relative_rotation < -PI:
		relative_rotation += 2 * PI
	#print("y: ", body.global_rotation.y, " ,target rotation: ", target_rotation, " , realtive rotation: ", relative_rotation)
	
	if abs(target_rotation - turret.global_rotation.y) < 0.05:
		return
	#elif body.global_rotation.y - target_rotation > 0.1:
	
	if relative_rotation > 0:
		turret.global_rotation.y += rotate_speed * delta
		view_component.global_rotation.y += rotate_speed *delta
	else:
		turret.global_rotation.y -= rotate_speed * delta
		view_component.global_rotation.y -= rotate_speed * delta

	#body.global_rotation.y = lerp_angle(body.global_rotation.y, atan2(v.x,v.z), rotate_speed)
	#view_component.global_rotation.y = lerp_angle(view_component.global_rotation.y, atan2(v.x,v.z), rotate_speed)
