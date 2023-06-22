extends KinematicBody

export var idleMaterial: Material
export var selectedMaterial: Material

onready var attack_component: Spatial = $Attack_component
onready var view_component: Area = $View_component
onready var body: MeshInstance = $body

onready var isSelected = false

export var rotate_speed := 0.02

func _ready():
	display_selected_unit()
	
func _process(delta: float) -> void:
	if attack_component.current_target != null:
		rotate_tower()
		
func rotate_tower():
	var target = attack_component.current_target
	var v = target.global_translation - global_translation
	body.global_rotation.y = lerp_angle(body.global_rotation.y, atan2(v.x,v.z), rotate_speed)
	view_component.global_rotation.y = lerp_angle(view_component.global_rotation.y, atan2(v.x,v.z), rotate_speed)
	
func _on_SelectionArea_selection_toggled(selection):
	isSelected = selection
	display_selected_unit()
	
func display_selected_unit():
	#$Label3D.visible = isSelected
	#print(body)
	if isSelected: body.material_override = selectedMaterial
	else: body.material_override = idleMaterial
